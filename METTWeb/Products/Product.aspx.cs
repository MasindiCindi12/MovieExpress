using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Singular;
using System.Web;
using System.Linq;
using Singular.Web;


namespace MEWeb.Products
{
    public partial class Product : MEPageBase<ProductVM>
    {
    }
    public class ProductVM : MEStatelessViewModel<ProductVM>
    {
        public MELib.Prod.ProductList ProductListing { get; set; }

        public MELib.Accounts.Account UserAccount { get; set; }
        int ProductID { get; set; }
        int UserID = Singular.Security.Security.CurrentIdentity.UserID;
        public MELib.Basket.BasketList myBasket { get; set; }

        public MELib.Security.UserList UserDetails { get; set; }
        public decimal Total = 0;
        // public string 

        /// <summary>
        /// Gets or sets the Movie Genre ID
        /// </summary>
        ///  
        // public int? ShipmentMethodID { get; set; }
        public int? ID { get; set; }


        [Singular.DataAnnotations.DropDownWeb(typeof(MELib.Shipment.ShipmentMethodList), Source = Singular.DataAnnotations.DropDownWeb.SourceType.All,
            UnselectedText = "Select Shipment ", DisplayMember = "ShipmentMethodName", ValueMember = "ShipmentMethodID")]
        [Display(Name = "Shipment Method")]


        public int? ShipmentMethodID { get; set; }
        public ProductVM()
        {

        }

        protected override void Setup()
        {
            base.Setup();
            
            UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));


            //Users
            UserAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();
            Total = Math.Round(MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID).Sum(x => x.TotalPrice), 2);
            myBasket = MELib.Basket.BasketList.GetBasketList(UserID);

            //Products
            ProductID = Convert.ToInt32(Page.Request.QueryString[0]);
            ProductListing = MELib.Prod.ProductList.GetProductList(ProductID);
          
        }

        public static void loadQuantity()
        {

            MELib.Products.ProductList ProductList = MELib.Products.ProductList.NewProductList();

        }
     
        public static void loadBalance()
        {

            MELib.Accounts.AccountList AccountList = MELib.Accounts.AccountList.GetAccountList();

        }

        [WebCallable(LoggedInOnly = true)]
        public Result AddToCart(int ProductID,  double Price, int Qty, DateTime RentalDate, MELib.Products.Product Product)
        {
            Result sr = new Result();
            if (Qty > 0)
            {
                int UserID = Singular.Settings.CurrentUserID;
               
                try
                {

                    MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList(ProductID);
                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem(ProductID);
                    //MELib.RO.ROUser Currentuser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();  ///Change

                    var BASKY = MELib.Basket.BasketList.GetBasketList(UserID).Count();
                    //Check the Quantity of products available
                    if (ProdSaveToBasket.Quantity != 0)
                    {
                        if (Qty <= ProdSaveToBasket.Quantity)
                        {

                            UserID = Singular.Settings.CurrentUserID;
                            MELib.RO.BasketList BasketList = MELib.RO.BasketList.GetBasketList(ProductID, UserID);
                            MELib.RO.Basket BasketItem = BasketList.GetItem(ProductID);

                            if (BasketItem != null && ProductID == BasketItem.ItemID && BasketItem.IsActiveInd == true)
                            {
                                BasketItem.itemQty = BasketItem.itemQty + Qty;
                                //BasketItem.MovieItemID = null;
                                var save = BasketItem.TrySave(typeof(MELib.RO.BasketList));

                                if (save.Success == true)
                                {
                                    sr.Success = true;
                                }
                                else
                                {
                                    sr.ErrorText = "Something Added After CSLA was createdd";
                                    sr.Success = false;
                                }
                            }
                            else
                            {
                                MELib.Basket.Basket myBasket = MELib.Basket.Basket.NewBasket();
                                myBasket.UserID = UserID;
                                myBasket.ItemID = ProdSaveToBasket.ProductID;
                                myBasket.ItemDescription = ProdSaveToBasket.ProductName;
                                myBasket.itemPrice = ProdSaveToBasket.Price;
                                myBasket.itemQty = Qty;
                                myBasket.IsActiveInd = true;
                                string prodName = myBasket.ItemDescription;

                                double subTotal = (Qty * Price);
                                myBasket.TotalPrice = (decimal)subTotal;

                                MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                                MELib.Accounts.Account Acc = myAccount.GetItem(UserID);
                                RentalDate = Convert.ToDateTime(DateTime.Today.ToString());

                                double myCurrentalance = (double)(myAccount.FirstAndOnly().Balance);
                                //Check The Balance
                                if (subTotal <= myCurrentalance)
                                {
                                    double tempBalance = 0;
                                    tempBalance = myCurrentalance - subTotal;

                                    var i = myBasket.TrySave(typeof(MELib.Basket.BasketList));
                                    Total = Math.Round(MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID).Sum(x => x.TotalPrice), 2);
                                    sr.Success = true;

                                }
                                else
                                {
                                    sr.ErrorText = "Please Fund Your Account. ";
                                    //Redirect
                                    sr.Success = false;
                                }

                            }

                        }
                        else
                        {

                            sr.ErrorText = " We have " + ProdSaveToBasket.Quantity + " " + ProdSaveToBasket.ProductName + " Remaining Items";
                            sr.Success = false;
                        }
                    }
                    else
                    {

                        sr.ErrorText = "You Can't Add " + ProdSaveToBasket.ProductName + "To Your Cart As It Is Out Of Stock";
                        sr.Success = false;
                    }
                    // sr.Success = true;
                }
                catch (Exception e)
                {
                    sr.ErrorText = "Product Not Added to Cart.";
                    sr.Success = false;
                }
            }

            else
            {
                sr.ErrorText = "You can not add 0 or less items to cart.";
                sr.Success = false;
            }
            return sr;
        }

        [WebCallable(LoggedInOnly = true)]
        public Result CheckOut(decimal Total, int shipmentMethodID, MELib.Basket.BasketList uncheckedBasket, MELib.Accounts.Account Account)
        {
            Result sr = new Result();
            if (shipmentMethodID > 0)
            {
                if (uncheckedBasket.Count > 0)
                {
                    int UserID = Singular.Security.Security.CurrentIdentity.UserID;

                    try
                    {


                        if (uncheckedBasket.Count > 0)
                        {
                            var uncheckedBasketList = uncheckedBasket;

                            MELib.Basket.BasketList unbasket = uncheckedBasketList;
                            int ProductID = 0;
                            int? ItemNo = 0;
                            var accountList = MELib.Accounts.AccountList.GetAccountList(UserID).FirstOrDefault();


                            MELib.Transactions.Transaction myTransaction = MELib.Transactions.Transaction.NewTransaction();

                            System.Text.StringBuilder myTransactionBuilder = new System.Text.StringBuilder();
                            foreach (MELib.Basket.Basket Item in unbasket)
                            {
                                if (Item.TotalPrice <= accountList.Balance)
                                {
                                    MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                                    MELib.Accounts.Account Acc = myAccount.GetItem(UserID);

                                    if (Item.ItemID > 0)
                                    {

                                        if (Item.TotalPrice <= accountList.Balance)
                                        {
                                            ItemNo = Item.ItemID;
                                            ProductID = Item.BasketID;
                                            MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList((int)ItemNo);
                                            MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem((int)ItemNo);
                                            MELib.RO.ROUser Currentuser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();  ///Change


                                            var productList = MELib.Products.ProductList.GetProductList(ProdSaveToBasket.ProductID);   /// we must still get project by id
                                            MELib.Products.Product product = productList.GetItem(ProdSaveToBasket.ProductID);
                                            product.Quantity -= Item.itemQty;

                                            var save0 = product.TrySave(typeof(MELib.Products.ProductList));

                                            if (save0.Success == true)
                                            {
                                                loadQuantity();
                                                sr.Success = true;
                                            }
                                            else
                                            {
                                                sr.Success = false;
                                            }



                                            Item.IsActiveInd = false;
                                            var b = Item.TrySave(typeof(MELib.Basket.BasketList));
                                            if (b.Success)
                                            {
                                                sr.Success = true;
                                            }
                                            else
                                            {
                                                sr.Success = false;
                                            }
                                            myTransaction.TransactionTypeID = 1;
                                            myTransaction.UserID = UserID;

                                            sr.Success = true;
                                        }
                                        else
                                        {
                                            sr.ErrorText = "Please Fund Your Account. " + $"../Profile/DepositFunds.aspx?";
                                            sr.Success = false;
                                        }
                                    }
                                    else
                                    {
                                        myTransaction.Description = Item.ItemDescription;
                                        Item.IsActiveInd = false;
                                        var moviSave = Item.TrySave(typeof(MELib.Basket.BasketList));
                                        if (moviSave.Success)
                                        {
                                            sr.Success = true;
                                        }
                                        else
                                        {
                                            sr.Success = false;
                                        }
                                        myTransaction.TransactionTypeID = 1;
                                        myTransaction.UserID = UserID;
                                    }

                                    myTransaction.Description += Item.ItemDescription + " @ R " + Item.itemPrice + " each  x " + Item.itemQty + " = R " + Item.TotalPrice + "\r\n" + "\n";
                                    myTransaction.Description += Environment.NewLine;

                                    myTransaction.Amount += (decimal)Item.TotalPrice;
                                }
                                else
                                {
                                    sr.ErrorText = "Fund Your Account.";
                                    sr.Success = false;
                                }
                            }

                            var iSave = myTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
                            if (iSave.Success == true)
                            {

                                accountList.Balance -= myTransaction.Amount;
                                var save = accountList.TrySave(typeof(MELib.Accounts.AccountList));


                                MELib.Transactions.Transaction accountTransaction = MELib.Transactions.Transaction.NewTransaction();
                                accountTransaction.UserID = accountList.UserID;
                                accountTransaction.TransactionTypeID = 1;
                                accountTransaction.Amount = myTransaction.Amount;
                                ///Transraction Type
                                ///
                                MELib.TransactionType.TransactionTypeList AcctransactionType = MELib.TransactionType.TransactionTypeList.GetTransactionTypeList(accountTransaction.TransactionTypeID);
                                MELib.TransactionType.TransactionType AcctransType = AcctransactionType.GetItem(myTransaction.TransactionTypeID);
                                accountTransaction.Description = AcctransType.TransactionTypeName;
                                accountTransaction.ShipmentMethodID = 1;
                                var iAccSave = myTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
                                if (iAccSave.Success == true)
                                {
                                    sr.Success = true;


                                }
                                else
                                {
                                    sr.ErrorText = "Transaction Not Created";
                                    sr.Success = false;
                                }
                            }
                          

                            sr.Data = MELib.Basket.BasketList.GetBasketList(UserID);
                            sr.Success = true;
                        }
                        else
                        {
                            sr.ErrorText = "Please Load Items To Check Out";
                            sr.Success = false;
                        }
                    }
                    catch (Exception e)
                    {
                        sr.ErrorText = "Product Not Added to Cart.";
                        e.ToString();
                    }


                }

                else
                {
                    sr.ErrorText = " Please Load Items To Your Cart First";
                    sr.Success = false;
                }
            }
            else
            {
                sr.ErrorText = "Please Select Shipment Method.";
                sr.Success = false;
            }
            return sr;
        }


    


        //Updating The Cart 
        [WebCallable]
        public Result UpdateCart(MELib.Basket.BasketList myBasket)
        {
           // Validation for items less than 1 ??
            Result sr = new Result();
            if (myBasket.IsValid)
            {
                var SaveResult = myBasket.TrySave();
                if (SaveResult.Success)
                {
                    sr.Data = SaveResult.SavedObject;
                    sr.Success = true;
                }
                else
                {
                    sr.ErrorText = SaveResult.ErrorText;
                    sr.Success = false;
                }
                return sr;
            }
            else
            {
                sr.ErrorText = myBasket.GetErrorsAsHTMLString();
                return sr;
            }
        }
    }

}