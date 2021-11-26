using MELib.RO;
using Singular.Web;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MEWeb.Products
{

    public partial class AllProducts : MEPageBase<AllProductsVM>
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
    public class AllProductsVM : MEStatelessViewModel<AllProductsVM>
    {
        public string LoggedInUserName { get; set; }

        public MELib.Products.ProductList ProductList { get; set; }

        //Gettting User data
        public MELib.Security.UserList UserDetails { get; set; }

      
        public int? ShipmentMethodID { get; set; }
        public MELib.Accounts.AccountList UserAccountList { get; set; }
        public MELib.Accounts.Account UserAccount { get; set; }

        public int UserId;
        public MELib.RO.ROUser users { get; set; }
        public decimal Total = 0;

        public AllProductsVM()
        { }


        protected override void Setup()
        {
            base.Setup();
            Total = Math.Round(MELib.Basket.BasketList.GetBasketList().Sum(x => x.TotalPrice), 2);

            ProductList = MELib.Products.ProductList.GetProductList();
            UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));


            UserAccountList = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID);
            // UserAccount = UserAccountList.();
            UserAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();


            LoggedInUserName = Singular.Security.Security.CurrentIdentity.UserName;
        }

        [WebCallable(LoggedInOnly = true)]
        public string ViewProduct(int ProductID)
        {
            var url = VirtualPathUtility.ToAbsolute("~/Products/Product.aspx?ProductID=" + HttpUtility.UrlEncode(ProductID.ToString()));
            return url;
        }

        public static void loadBalance()
        {

            MELib.Accounts.AccountList AccountList = MELib.Accounts.AccountList.GetAccountList();

        }
        public static void loadQuantity()
        {

            MELib.Products.ProductList ProductList = MELib.Products.ProductList.GetProductList();

        }
        /// <summary>
        /// /  var Deposit = function () {
     //   window.location = '../Profile/DepositFuds.aspx';
    //    }

    /// </summary>
    /// <param name="Account"></param>
    /// <returns></returns>
    [WebCallable]
        public static Result SaveAccountList(MELib.Accounts.Account Account)
        {
            if (Account.Balance > 0)
            {
                var accountList = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();

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
                    loadBalance();
                }
            }
            else
            {
                // sr.ErrorText = "You can not add 0 or less items to cart.";
                return new Singular.Web.Result() { ErrorText = " You can not add any amount less than R1 ", Success = false };
                loadBalance();
            }
            loadBalance();
        }


        [WebCallable]
        public Result CheckOut(decimal Total, int shipmentMethodID, MELib.Basket.BasketList uncheckedBasket, MELib.Accounts.Account Account)
        {

            Result sr = new Result();
            if (shipmentMethodID > 0)
            {
                if (uncheckedBasket != null)
                {
                    if (uncheckedBasket.Count > 0)
                    {


                        try
                        {
                            var uncheckedBasketList = uncheckedBasket;
                            //ROProductList SaveProd = ROProductList.GetProductList();
                            MELib.Basket.BasketList unbasket = uncheckedBasketList;
                            int ProductID = 0;
                            int? ItemNo = 0;

                            foreach (MELib.Basket.Basket Item in unbasket)
                            {
                                ItemNo = Item.ItemID;
                                ProductID = Item.BasketID;
                                ROProductList SaveProd = ROProductList.GetProductList((int)ItemNo);
                                ROProduct ProdSaveToBasket = SaveProd.GetItem((int)ItemNo);
                                ROUser Currentuser = ROUserList.GetROUserList().FirstOrDefault();  ///Change

                                int Qty = 0;
                                if (Item.itemQty <= ProdSaveToBasket.Quantity)
                                {
                                    Item.IsActiveInd = false;  //.IsActiveInd = false;
                                                               //string prodName = myBasket.ItemDescription;
                                    int Price = 0;
                                    double subTotal = (Qty * Price);
                                    MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList((Singular.Security.Security.CurrentIdentity.UserID));
                                    MELib.Accounts.Account Acc = myAccount.GetItem((Singular.Security.Security.CurrentIdentity.UserID));

                                    double myCurrentalance = (double)(myAccount.FirstAndOnly().Balance);
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
                                            //     myTransaction.Description=
                                            myTransaction.UserID = Singular.Security.Security.CurrentIdentity.UserID;
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

                                    sr.Data = MELib.Basket.BasketList.GetBasketList((Singular.Security.Security.CurrentIdentity.UserID));
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

                    }

                    else
                    {
                        sr.ErrorText = "Please Load Items To Your Cart.";
                        sr.Success = false;
                    }
                }
                else
                {
                    sr.ErrorText = "Please Load Items To Your Cart.";
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
                    loadBalance();
                }
                else
                {
                    loadBalance();
                    sr.ErrorText = SaveResult.ErrorText;
                    sr.Success = false;
                }
                return sr;
            }
            else
            {
                sr.ErrorText = ProductList.GetErrorsAsHTMLString();
                loadBalance();
                return sr;
            }
        }

    }
}