using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;

namespace MEWeb.Products
{
    public partial class UserProductCart : MEPageBase<UserProductCartVM>
    {

    }


    public class UserProductCartVM : MEStatelessViewModel<UserProductCartVM>
    {

        public MELib.RO.ROProductCategoryList CategoryList { get; set; }
        public MELib.Products.ProductList ProductList { get; set; }

        public MELib.Products.ProductList ProductListById { get; set; }

        // Filter Criteria
        public MELib.RO.ROProductCategoryList ProductCategoryList { get; set; }

        public MELib.Basket.BasketList myBasketList { get; set; }


       

        [Display(Name = "Username", Description = " "),
        Singular.DataAnnotations.DropDownWeb(typeof(MELib.RO.ROUserList), Source = Singular.DataAnnotations.DropDownWeb.SourceType.All, UnselectedText = "Select User", DisplayMember = "UserName", ValueMember = "UserID")]

        public int? UserId { get; set; }


        public MELib.RO.ROUser users { get; set; }
        public int CategoryID { get; set; }
        public int ProductID { get; set; }
        public MELib.Accounts.Account UserAccount { get; set; }
        public MELib.Basket.BasketList myBasket { get; set; }

        public decimal Total = 0;
        public UserProductCartVM()
        { }


        protected override void Setup()
        {
            base.Setup();


            //users = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();
            //UserAccount = MELib.Accounts.AccountList.GetAccountList().FirstOrDefault();
            //CategoryList = MELib.RO.ROProductCategoryList.GetROProductCategoryList();
            ProductList = MELib.Products.ProductList.GetProductList();
            ////ProductListById = MELib.Products.ProductList.GetProductList(ProductID);

            //ProductCategoryList = MELib.RO.ROProductCategoryList.GetROProductCategoryList(CategoryID);

            UserId = 0;
            Total = Math.Round(MELib.Basket.BasketList.GetBasketList((int)UserId).Sum(x => x.TotalPrice), 2);

            ///


        }



        public static void loadBalance()
        {

            MELib.Accounts.AccountList AccountList = MELib.Accounts.AccountList.GetAccountList();

        }
        public static void loadQuantity()
        {

            MELib.Products.ProductList ProductList = MELib.Products.ProductList.NewProductList();

        }

        [WebCallable(LoggedInOnly = true)]
        public Result UserInfo(int UserId)
        {

            Result sr = new Result();
            if (UserId > 0)
            {
                try
                {
                    MELib.Basket.BasketList myBasket = MELib.Basket.BasketList.GetBasketList(UserId);

                    if (myBasket != null)
                    {
                        sr.Data = myBasket;
                        // Total = Math.Round(MELib.Basket.BasketList.GetBasketList(UserId).Sum(x => x.TotalPrice), 2);
                        sr.Success = true;
                    }
                    else
                    {
                        sr.ErrorText = "Please Add Items To Your Cart.";
                        sr.Success = false;
                    }
                }
                catch (Exception ex)
                {
                    ex.ToString();
                }
            }
            else
            {
                sr.ErrorText = "Please Select The User";
                sr.Success = false;
            }
            return sr;
        }

        public static void loadBasket()
        {
            MELib.Security.User user = MELib.Security.UserList.GetUserList().FirstAndOnly();
            MELib.Basket.BasketList BasketList = MELib.Basket.BasketList.GetBasketList(user.UserID);

        }

        [WebCallable(LoggedInOnly = true)]
        public Result CheckOut(MELib.Basket.BasketList uncheckedBasket, MELib.Accounts.Account Account, int UserId)
        {
            int UserID = UserId;
            Result sr = new Result();
            try
            {
                var uncheckedBasketList = uncheckedBasket;

                MELib.Basket.BasketList unbasket = uncheckedBasketList;

                int? ItemNo = 0;

                foreach (MELib.Basket.Basket Item in unbasket)
                {
                    int ProductID = (int)Item.ItemID;
                    MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList(ProductID);
                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem(ProductID);
                    if (Item.itemQty <= ProdSaveToBasket.Quantity)
                    {
                        MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                        MELib.Accounts.Account Acc = myAccount.GetItem(UserID);
                        ProdSaveToBasket.Quantity -= Item.itemQty;
                        //  var i = ProdSaveToBasket.TrySave(typeof(MELib.Products.ProductList));     /// Breaking  Cheing Out

                        var accountList = MELib.Accounts.AccountList.GetAccountList().FirstOrDefault();
                        accountList.Balance -= Item.itemPrice;

                        if (Item.TotalPrice <= accountList.Balance)
                        {
                            ItemNo = Item.ItemID;
                            ProductID = Item.BasketID;
                            // MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList((int)ItemNo);
                            //MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem((int)ItemNo);
                         

                            //Value to update
                            Item.IsActiveInd = false;
                            var b = Item.TrySave(typeof(MELib.Basket.BasketList));

                            MELib.Transactions.Transaction myTransaction = MELib.Transactions.Transaction.NewTransaction();
                            myTransaction.TransactionTypeID = 1;
                            myTransaction.Amount = (decimal)Item.TotalPrice;
                            myTransaction.UserID = UserID;
                            // accountList.Balance -= Item.TotalPrice;
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

                            var t = myTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
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

                        sr.ErrorText = "Available Items for the selected products are less than what you request. We have " + ProdSaveToBasket.Quantity + " Remaining Items";
                        sr.Success = false;
                    }

                }

                sr.Data = MELib.Basket.BasketList.GetBasketList(UserID);
                sr.Success = true;
            }
            catch (Exception e)
            {
                sr.ErrorText = "Product Not Added to Cart.";
                e.ToString();
            }

            return sr;
        }

   
        [WebCallable(LoggedInOnly = true)]
        public Result AddToCart(int ProductID, double Price, int Qty, int UserId, MELib.Products.Product Product)
        {

            int UserID = UserId;
            Result sr = new Result();
            try
            {
                if (UserId > 0)
                {
                    MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList(ProductID);
                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem(ProductID);

                    var BASKY = MELib.Basket.BasketList.GetBasketList(UserId);
                    if (Qty <= ProdSaveToBasket.Quantity)
                    {
                        UserID = UserId;
                        MELib.RO.BasketList BasketList = MELib.RO.BasketList.GetBasketList(ProductID, UserID);
                        MELib.RO.Basket BasketItem = BasketList.GetItem(ProductID);

                        if (BasketItem != null && ProductID == BasketItem.ItemID && BasketItem.IsActiveInd == true)
                        {
                            BasketItem.itemQty = BasketItem.itemQty + Qty;

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
                            myBasket.UserID = UserId;
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
                                    Total = Math.Round(MELib.Basket.BasketList.GetBasketList((int)UserId).Sum(x => x.TotalPrice), 2);

                                    var productList = MELib.Products.ProductList.GetProductList().FirstOrDefault();   /// we must still get project by id
                                    //productList.Quantity -= myBasket.itemQty;

                                    var save = productList.TrySave(typeof(MELib.Products.ProductList));

                                    if (save.Success == true)
                                    {
                                        return new Singular.Web.Result() { Success = true };
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
                        sr.ErrorText = "Available Items for the selected products are less than what you request. We have " + ProdSaveToBasket.Quantity + " Remaining Items";
                        sr.Success = false;
                    }

                }
                else
                {
                    sr.ErrorText = "Please Select The User You Would Like To Purchase For.";
                    sr.Success = false;
                }
            }
            catch (Exception e)
            {
                sr.ErrorText = "Product Not Added to Cart." + e.ToString();
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

    }


}