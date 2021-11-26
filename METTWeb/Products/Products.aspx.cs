using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;



namespace MEWeb.Products
{
   public partial class Products : MEPageBase<ProductsVM>
   {
    }
    public class ProductsVM : MEStatelessViewModel<ProductsVM>
    {
        public MELib.Products.ProductList ProductList { get; set; }
        public MELib.RO.ROProductCategoryList ROCategoryListPage { get; set; }
        public MELib.Accounts.AccountList AccountList { get; set; }
        public MELib.Security.UserList UserDetails { get; set; }

        public MELib.Basket.BasketList myBasket { get; set; }
        //Filter Criteria 
        public DateTime StockedDate { get; set; }


        public decimal Total = 0;
        [Singular.DataAnnotations.DropDownWeb(typeof(MELib.RO.ROProductCategoryList), UnselectedText = "Select", ValueMember = "CategoryID", DisplayMember = "CategoryName")]
        [Display(Name = "CategoryName")]
        public MELib.Accounts.Account UserAccount { get; set; }
        public int? CategoryID { get; set; }
        public ProductsVM()
        {

        }

        protected override void Setup()
        {
            base.Setup();


            UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));
            UserAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();
            ROCategoryListPage = MELib.RO.ROProductCategoryList.GetROProductCategoryList();
            ProductList = MELib.Products.ProductList.GetProductList();
            AccountList = MELib.Accounts.AccountList.GetAccountList();
            myBasket = MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID);

          Total = Math.Round(MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID).Sum(x => x.TotalPrice), 2);
        }


        public static void loadBalance()
        {

            MELib.Accounts.AccountList AccountList = MELib.Accounts.AccountList.GetAccountList();

        }
        [WebCallable(LoggedInOnly = true)]

        public Result AddToCart(int ProductID,  double Price, int Quantity)
        {
            Result sr = new Result();
            if (Quantity > 0)
            {  
                try
                {
                    MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList(ProductID);
                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem(ProductID);
                    MELib.RO.ROUser Currentuser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();  ///Change

                    //Check the Quantity of products available
                    if (Quantity <= ProdSaveToBasket.Quantity)
                    {

                       int  UserID = Singular.Security.Security.CurrentIdentity.UserID;
                        MELib.RO.BasketList BasketList = MELib.RO.BasketList.GetBasketList(ProductID, UserID);
                        MELib.RO.Basket BasketItem = BasketList.GetItem(ProductID);

                        if (BasketItem != null && ProductID == BasketItem.ItemID && BasketItem.IsActiveInd == true)
                        {
                            BasketItem.itemQty = BasketItem.itemQty + Quantity;

                            var save = BasketItem.TrySave(typeof(MELib.RO.BasketList));

                            if (save.Success == true)
                            {
                                sr.Success = true;
                            }
                            else
                            {
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
                            myBasket.itemQty = Quantity;
                            myBasket.IsActiveInd = true;
                            myBasket.BasketDate = DateTime.Parse(DateTime.Now.ToString());
                            string prodName = myBasket.ItemDescription;

                            double subTotal = (Quantity * Price);
                            myBasket.TotalPrice = (decimal)subTotal;

                            MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                            MELib.Accounts.Account Acc = myAccount.GetItem(UserID);

                            if (Quantity <= ProdSaveToBasket.Quantity)
                            {
                                var i = myBasket.TrySave(typeof(MELib.Basket.BasketList));
                                if (i.Success == true)
                                {
                                    var productList = MELib.Products.ProductList.GetProductList().FirstOrDefault();   /// we must still get project by id
                                    //productList.Quantity -= myBasket.itemQty;

                                    var save = productList.TrySave(typeof(MELib.Products.ProductList));

                                    if (save.Success == true)
                                    {
                                        sr.Success = true;
                                       

                                    }
                                    else
                                    {
                                        sr.ErrorText = "Unable To Update Product.";

                                        sr.Success = false;
                                    }
                                }
                                else
                                {
                                    sr.ErrorText = "Could Not Add Item To Cart.";
                                    sr.Success = false;
                                }
                            }
                            else
                            {
                                sr.ErrorText = "Available Items for the selected products are less than what you request. We have " + ProdSaveToBasket.Quantity + " Remaining Items";
                                sr.Success = false;
                            }

                        }


                    }
                    else
                    {

                        sr.ErrorText = "Available Items for the selected products are less than what you request.";
                        sr.Success = false;
                    }
                    sr.Success = true;
                }
                catch (Exception e)
                {
                    sr.ErrorText = "Product Not Added to Cart.";
                    sr.Success = false;
                }
            }
            else
            {
                sr.ErrorText = "You can not add zero (0) or less Items to the Cart";
                sr.Success = false;
            }
            return sr;
        }

        //public Result AddToCart(int ProductID, int UserID, double Price, int Quantity, DateTime RentalDate, MELib.Products.Product Product)
        //{

        //    Result sr = new Result();
        //    try
        //    {

        //        MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList(ProductID);
        //        MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem(ProductID);
        //        MELib.RO.ROUser Currentuser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();  ///Change

        //        //Check the Quantity of products available
        //        if (Quantity <= ProdSaveToBasket.Quantity)
        //        {
        //            MELib.Basket.Basket myBasket = MELib.Basket.Basket.NewBasket();
        //            myBasket.UserID = Currentuser.UserID;
        //            myBasket.ItemID = ProdSaveToBasket.ProductID;
        //            myBasket.ItemDescription = ProdSaveToBasket.ProductName;
        //            myBasket.itemPrice = ProdSaveToBasket.Price;
        //            myBasket.itemQty = Quantity;
        //            myBasket.IsActiveInd = true;
        //            string prodName = myBasket.ItemDescription;


        //            //Calculating the total cost
        //            double subTotal = (Quantity * Price);
        //            MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);

        //            //Get the user account
        //            MELib.Accounts.Account Acc = myAccount.GetItem(UserID);

        //            RentalDate = Convert.ToDateTime(DateTime.Today.ToString());

        //            double myCurrentalance = (double)(myAccount.FirstAndOnly().Balance);
        //            //Check The Balance
        //            if (subTotal <= myCurrentalance)
        //            {
        //                var i = myBasket.TrySave(typeof(MELib.Basket.BasketList));
        //                sr.Success = true;
        //                //Reduce the product Quantity

        //                //Update the available Quantity  and the user balance
        //            }
        //            else
        //            {
        //                sr.ErrorText = "Please Fund Your Account. ";
        //                var url = $"../Profile/DepositeFunds.aspx";
        //                sr.Success = false;
        //            }

        //        }
        //        else
        //        {

        //            sr.ErrorText = "Available Items for the selected products are less than what you request.";
        //            sr.Success = false;
        //        }
        //        sr.Success = true;
        //    }
        //    catch (Exception e)
        //    {
        //        sr.ErrorText = "Product Not Added to Cart.";
        //        sr.Success = false;
        //    }

        //    return sr;
        //}

        [WebCallable(LoggedInOnly = true)]
        public Result CheckOut(MELib.Basket.BasketList uncheckedBasket, MELib.Accounts.Account Account)
        {
            int UserID = Singular.Security.Security.CurrentIdentity.UserID;
            Result sr = new Result();
            try
            {
                var uncheckedBasketList = uncheckedBasket;
                
                MELib.Basket.BasketList unbasket = uncheckedBasketList;
                int ProductID = 0;
                int? ItemNo = 0;

                foreach (MELib.Basket.Basket Item in unbasket)
                {
                    ItemNo = Item.ItemID;
                    ProductID = Item.BasketID;
                    MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList((int)ItemNo);
                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem((int)ItemNo);
                    MELib.RO.ROUser Currentuser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();  ///Change

                    int Qty = 0;
                    if (Qty <= ProdSaveToBasket.Quantity)
                    {
                       
                        Item.IsActiveInd = false;  

                       
                        decimal subTotal = (Qty * Item.itemPrice);
                        MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                        MELib.Accounts.Account Acc = myAccount.GetItem(UserID);
                        //RentalDate = Convert.ToDateTime(DateTime.Today.ToString());

                        decimal myCurrentalance = (decimal)(myAccount.FirstAndOnly().Balance);
                        //Check The Balance
                        if (subTotal <= myCurrentalance)
                        {
                            //myBasket.IsActiveInd = false;
                            var b = Item.TrySave(typeof(MELib.Basket.BasketList));
                            if (b.Success == true)
                            {
                                ProdSaveToBasket.Quantity -= Qty;//Reduce the product Quantity
                                MELib.Transactions.Transaction myTransaction = MELib.Transactions.Transaction.NewTransaction();
                                myTransaction.TransactionTypeID = 1;
                                myTransaction.Amount = (decimal)subTotal;
                                myTransaction.UserID = 1234;
                                //Acc.Balance -= (decimal)subTotal;



                                var accountList = MELib.Accounts.AccountList.GetAccountList().FirstOrDefault();

                                accountList.Balance += Account.Balance;

                                var save = accountList.TrySave(typeof(MELib.Accounts.AccountList));

                                if (save.Success == true)
                                {
                                    return new Singular.Web.Result() { Success = true };
                                    loadBalance();

                                }
                                else
                                {
                                    return new Singular.Web.Result() { Success = false };
                                }

                                loadBalance();


                                loadBalance();
                                // var UserBalance = Acc.TrySave(typeof(MELib.Accounts.AccountList));
                                var i = myTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
                                sr.Success = true;
                            }
                            else
                            {
                                sr.Success = false;
                            }

                            //Update the available Quantity  and the user balance
                        }
                        else
                        {
                            sr.ErrorText = "Please Fund Your Account. " + $"../Profile/DepositFunds.aspx?";
                            sr.Success = false;
                        }

                        sr.Data = MELib.Basket.BasketList.GetBasketList(UserID);
                        sr.Success = true;
                    }
                    else
                    {

                        sr.ErrorText = "Available Items for the selected products are less than what you request.";
                        sr.Success = false;
                    }
                }


                //Check the Quantity of products available

            }
            catch (Exception e)
            {
                sr.ErrorText = "Product Not Added to Cart.";
                e.ToString();
            }


         
            return sr;



        }
        //Updating The Cart 
        [WebCallable]
        public Result SaveCartList(MELib.Basket.BasketList myBasket)
        {
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

            [WebCallable]
        public static Result SaveAccountList(MELib.Accounts.Account myAccount)
        {
            int UserId = Singular.Security.Security.CurrentIdentity.UserID;

            Result sr = new Result();
            if (UserId > 0)
            {

                MELib.Accounts.Account myNewAccount = MELib.Accounts.Account.NewAccount();

                myNewAccount.UserID = myAccount.UserID;
                myNewAccount.AccountTypeID = 2;
                myNewAccount.Balance = myAccount.Balance;

                var save = myNewAccount.TrySave(typeof(MELib.Accounts.AccountList));

                if (save.Success == true)
                {
                    MELib.Transactions.Transaction accountTransaction = MELib.Transactions.Transaction.NewTransaction();
                    accountTransaction.UserID = myAccount.UserID;
                    accountTransaction.TransactionTypeID = 2;
                    accountTransaction.Amount = myNewAccount.Balance;
                    ///Transraction Type
                    ///
                    MELib.TransactionType.TransactionTypeList AcctransactionType = MELib.TransactionType.TransactionTypeList.GetTransactionTypeList(accountTransaction.TransactionTypeID);
                    MELib.TransactionType.TransactionType AcctransType = AcctransactionType.GetItem(accountTransaction.TransactionTypeID);
                    accountTransaction.Description = AcctransType.TransactionTypeName;
                    accountTransaction.ShipmentMethodID = 0;

                    var iAccSave = accountTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
                    if (iAccSave.Success == true)
                    {
                        sr.Success = true;
                    }
                    else
                    {
                        sr.ErrorText = "Transaction Not Created";
                        sr.Success = false;
                    }
                    return new Singular.Web.Result() { Success = true };
                }
                else
                {
                    sr.ErrorText = "User Funds Not Updated.";
                    sr.Success = false;
                }
                return new Singular.Web.Result() { Success = true };
            }
            else
            {
                sr.ErrorText = "User Not Found!.";
                sr.Success = false;
            }


            return sr;
        }



        [WebCallable]
        public Result FilterProducts(int CategoryID,int ResetInd)
        {
            Result sr = new Result();
            try
            {
                if (ResetInd == 0)
                {
                    MELib.Products.ProductList ProductList = MELib.Products.ProductList.GetProductList(CategoryID);
                    sr.Data = ProductList;
                }
                else
                {
                    MELib.Products.ProductList ProductList = MELib.Products.ProductList.GetProductList();
                    sr.Data = ProductList;
                }
                sr.Success = true;
            }
            catch (Exception e)
            {
                WebError.LogError(e, "Page: Products.aspx | Method: FilterProducts", $"(int CategoryID, ({CategoryID})");
                sr.Data = e.InnerException;
                sr.ErrorText = "Could not filter products by category.";
                sr.Success = false;
            }
            return sr;
        }

 
    }
   
}