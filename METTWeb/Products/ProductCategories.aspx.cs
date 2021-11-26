using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular;
using Singular.Web;


namespace MEWeb.Products
{
    public partial class ProductCategories : MEPageBase<ProductCategoriesVM>
    {

    }
    public class ProductCategoriesVM : MEStatelessViewModel<ProductCategoriesVM>
    {

        public MELib.RO.ROProductCategoryList CategoryList { get; set; }


        public MELib.Products.ProductList ProductList { get; set; }

        public MELib.Products.ProductList ProductListById { get; set; }
        
        // Filter Criteria
        public MELib.RO.ROProductCategoryList ProductCategoryList { get; set; }

        public MELib.Basket.BasketList myBasketList { get; set; }


        int UserID = Singular.Security.Security.CurrentIdentity.UserID;

        [Display(Name = "Category Name", Description = " "),
        Singular.DataAnnotations.DropDownWeb(typeof(MELib.Categories.CategoryList), Source = Singular.DataAnnotations.DropDownWeb.SourceType.All, UnselectedText = "Select Category", DisplayMember = "CategoryName", ValueMember = "CategoryID")]


        public int CategoryID { get; set; }

        public int? ShipmentMethodID { get; set; }

 
        public int ProductID { get; set; }
        public MELib.Accounts.Account UserAccount { get; set; }
        public  MELib.Basket.BasketList myBasket { get;set;}

       public decimal Total = 0;


        //user account
         public MELib.Accounts.Account AccountList { get; set; }
        public MELib.Security.UserList UserDetails { get; set; }
        public MELib.RO.ROUser users { get; set; }
        public ProductCategoriesVM()
        { }

        protected override void Setup()
        {
            base.Setup();


            //User Details
            UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));
            //User Account List
            AccountList = MELib.Accounts.AccountList.GetAccountList().FirstOrDefault();

          
            UserAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();
            CategoryList = MELib.RO.ROProductCategoryList.GetROProductCategoryList();
             ProductList = MELib.Products.ProductList.GetProductList();
             ProductListById = MELib.Products.ProductList.GetProductList(ProductID);

            ProductCategoryList = MELib.RO.ROProductCategoryList.GetROProductCategoryList(CategoryID);
            myBasket = MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID);

            Total = Math.Round(MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID).Sum(x => x.TotalPrice), 2);

            ///
            myBasketList = MELib.Basket.BasketList.GetBasketList();
        }

        public static void loadBalance()
        {

            MELib.Accounts.AccountList AccountList = MELib.Accounts.AccountList.GetAccountList();

        }
        public static void loadQuantity()
        {

            MELib.Products.ProductList ProductList = MELib.Products.ProductList.NewProductList();

        }


        public static void loadBasket()
        {
            MELib.Security.User user = MELib.Security.UserList.GetUserList().FirstAndOnly();
            MELib.Basket.BasketList BasketList = MELib.Basket.BasketList.GetBasketList(user.UserID);

        }

        [WebCallable(LoggedInOnly = true)]
        public Result CheckOut(decimal Total, int shipmentMethodID, MELib.Basket.BasketList uncheckedBasket, MELib.Accounts.Account Account)
        {

            int shipID = shipmentMethodID;
            Result sr = new Result();
            if (shipID > 0)
            {
                int UserID = Singular.Security.Security.CurrentIdentity.UserID;

                if (uncheckedBasket.Count > 0)
                {
                    try
                    {
                        var uncheckedBasketList = uncheckedBasket;

                        MELib.Basket.BasketList unbasket = uncheckedBasketList;
                        int ProductID = 0;
                        int? ItemNo = 0;
                        var accountList = MELib.Accounts.AccountList.GetAccountList(UserID).FirstOrDefault();

                        MELib.Transactions.Transaction myTransaction = MELib.Transactions.Transaction.NewTransaction();


                        MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                        MELib.Accounts.Account Acc = myAccount.GetItem(UserID);
                        decimal totalPrice = Total;
                        if (accountList.Balance >= totalPrice)
                        {
                            MELib.Shipment.ShipmentMethodList myShipment = MELib.Shipment.ShipmentMethodList.GetShipmentMethodList(shipmentMethodID);
                            MELib.Shipment.ShipmentMethod processingShipmentMethod = myShipment.GetItem(shipmentMethodID);

                            string deliveryMethod = processingShipmentMethod.ShipmentMethodName;
                            decimal deliveryPrice = processingShipmentMethod.Price;

                            System.Text.StringBuilder myTransactionBuilder = new System.Text.StringBuilder();
                            foreach (MELib.Basket.Basket Item in unbasket)
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

                                    myTransaction.TransactionTypeID = 1;
                                    myTransaction.UserID = UserID;

                                    sr.Success = true;
                                }



                                myTransaction.Description += Item.ItemDescription + " @ R " + Item.itemPrice + " each  x " + Item.itemQty + " = R " + Item.TotalPrice + "\r\n" + "\n";
                                myTransaction.Description += Environment.NewLine;

                                myTransaction.Amount += (decimal)Item.TotalPrice;
                            }

                            myTransaction.Description += "\r\n" + "\n" + "Delivery Method " + deliveryMethod;
                            myTransaction.Amount += deliveryPrice;

                            var SaveResult = myTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
                            if (SaveResult.Success)
                            {
                                accountList.Balance -= myTransaction.Amount;
                                var Save = accountList.TrySave(typeof(MELib.Accounts.AccountList));
                                if (Save.Success)
                                {
                                    sr.Data = MELib.Basket.BasketList.GetBasketList(UserID);
                                    sr.Data = SaveResult.SavedObject;
                                    sr.Success = true;
                                }
                                else
                                {
                                    sr.ErrorText = "Account not Updated";
                                    sr.Success = false;
                                }



                            }
                            else
                            {
                                sr.ErrorText = "Transaction not Successful";
                                sr.Success = false;
                            }

                        }
                        else
                        {
                            sr.ErrorText = "Fund Your Account.";
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
                    sr.ErrorText = "Please Items Load to Cart.";
                    sr.Success = false;
                }
            }
            else
            {
                sr.ErrorText = "Please Select a shipment method.";
                sr.Success = false;
            }
            return sr;
        }



        [WebCallable(LoggedInOnly = true)]
        public Result AddToCart(int ProductID, double Price,int Qty, DateTime RentalDate , MELib.Products.Product Product)
        {
            Result sr = new Result();
            if (Qty > 0)
            {

                try
                {

                    MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList(ProductID);
                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem(ProductID);

                    var BASKY = MELib.Basket.BasketList.GetBasketList(Singular.Settings.CurrentUserID);
                    if (Qty <= ProdSaveToBasket.Quantity)
                    {
                        UserID = Singular.Settings.CurrentUserID;
                        MELib.RO.BasketList BasketList = MELib.RO.BasketList.GetBasketList(ProductID,UserID);
                        MELib.RO.Basket BasketItem = BasketList.GetItem(ProductID);

                        if (BasketItem !=null && ProductID == BasketItem.ItemID && BasketItem.IsActiveInd == true)
                        {
                            BasketItem.itemQty = BasketItem.itemQty + Qty;

                            var save = BasketItem.TrySave(typeof(MELib.RO.BasketList));

                            if (save.Success == true)
                            {
                              sr.Success = true ;
                            }
                            else
                            {
                                sr.ErrorText = "Product Not Added To Cart";
                               sr.Success = false ;
                            }
                        }
                        else
                        {
                            MELib.Basket.Basket myBasket = MELib.Basket.Basket.NewBasket();
                            myBasket.UserID = Singular.Security.Security.CurrentIdentity.UserID;
                            myBasket.ItemID = ProdSaveToBasket.ProductID;
                            myBasket.ItemDescription = ProdSaveToBasket.ProductName;
                            myBasket.itemPrice = ProdSaveToBasket.Price;
                            myBasket.itemQty = Qty;
                            myBasket.IsActiveInd = true;
                            myBasket.BasketDate = DateTime.Parse(DateTime.Now.ToString());
                            string prodName = myBasket.ItemDescription;

                            double subTotal = (Qty * Price);
                            myBasket.TotalPrice = (decimal)subTotal;

                            MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                            MELib.Accounts.Account Acc = myAccount.GetItem(UserID);

                            if (Qty <= ProdSaveToBasket.Quantity)
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
                                        loadQuantity();

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
                        MELib.Basket.Basket myBasket = MELib.Basket.Basket.NewBasket();
                        myBasket.UserID = Singular.Settings.CurrentUserID;
                        myBasket.ItemID = ProdSaveToBasket.ProductID;
                        myBasket.ItemDescription = ProdSaveToBasket.ProductName;
                        myBasket.itemPrice = ProdSaveToBasket.Price;
                        myBasket.itemQty = Qty;
                        myBasket.IsActiveInd = true;
                        string prodName = myBasket.ItemDescription;


                        //Calculating the total cost
                        double subTotal = (Qty * Price);
                        MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID);

                        //Get the user account
                        MELib.Accounts.Account Acc = myAccount.GetItem(Singular.Security.Security.CurrentIdentity.UserID);

                        RentalDate = Convert.ToDateTime(DateTime.Today.ToString());


                        var i = myBasket.TrySave(typeof(MELib.Basket.BasketList));
                        if (i.Success == true)
                        {
                            sr.Success = true;
                        }
                        else
                        {
                            sr.ErrorText = "Item(s) not added to cart.";
                        }

                    }
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
        public Result FilterProducts(int CategoryID)
        {
            Result sr = new Result();
            try
            {
                
                MELib.Products.ProductList productList = MELib.Products.ProductList.GetProductList();
                MELib.Product.CategoryProductList ProdList = MELib.Product.CategoryProductList.GetCategoryProductList(CategoryID);
                sr.Data = ProductList;
                sr.Success = true;

                
            }
            catch (Exception e)
            {
                WebError.LogError(e, "Page: ProductCategories.aspx | Method: FilterProducts", $"(int CategoryID, ({CategoryID})");
                sr.Data = e.InnerException;
                sr.ErrorText = "Could not filter movies by category.";
                sr.Success = false;
            }
            return sr;
        }

        //deposite
        [WebCallable]
        public static Result SaveAccountList(MELib.Accounts.Account Account)
        {
            if (Account.Balance > 0)
            {
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
            }

            else
            {
                // sr.ErrorText = "You can not add 0 or less items to cart.";
                return new Singular.Web.Result() { ErrorText = " You can not add any amount less than R1 ", Success = false };
            }
            loadBalance();
        }





    }




}

