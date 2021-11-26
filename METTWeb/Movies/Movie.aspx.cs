using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Org.BouncyCastle.Asn1.Ocsp;
using Singular.Web;

namespace MEWeb.Movies
{
  public partial class Movie : MEPageBase<MovieVM>
  {
  }
    public class MovieVM : MEStatelessViewModel<MovieVM>
    {
        public MELib.Movies.MovieList MovieList { get; set; }
        public MELib.Basket.BasketList myBasket { get; set; }
        //public MELib.Accounts.AccountList UserAccount { get; set; }

        public MELib.Accounts.Account UserAccount { get; set; }
        int MovieID { get; set; }
        public decimal Total = 0;


        public MELib.Security.UserList UserDetails { get; set; }
        // public string 
        public MovieVM()
        {

        }
        protected override void Setup()
        {
            int UserID = Singular.Security.Security.CurrentIdentity.UserID;
            base.Setup();
        

            //Movie Details
            MovieID = System.Convert.ToInt32(Page.Request.QueryString[0]);
            MovieList = MELib.Movies.MovieList.GetMovieList(MovieID);



            UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));


            //Users
            UserAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();
            Total = Math.Round(MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID).Sum(x => x.TotalPrice), 2);
            ///User Details
            //UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));
            //UserAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID);
            myBasket = MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID);
            Total = Math.Round(MELib.Basket.BasketList.GetBasketList(Singular.Security.Security.CurrentIdentity.UserID).Sum(x => x.TotalPrice), 2);
        }

        [WebCallable(LoggedInOnly = true)]
        public Result AddToCart(int MovieID,  double Price, MELib.Movies.Movie movie)
        {

            int UserID = Singular.Settings.CurrentUserID;

            //
            Result sr = new Result();
            try
            {  MELib.Movies.MovieList SaveProd = MELib.Movies.MovieList.GetMovieList(MovieID);

                MELib.Movies.Movie ProdSaveToBasket = SaveProd.GetItem(MovieID);
              

                var BASKY = MELib.Basket.BasketList.GetBasketList(Singular.Settings.CurrentUserID).Count();
               
                MELib.Basket.Basket myBasket = MELib.Basket.Basket.NewBasket();
                myBasket.UserID = Singular.Security.Security.CurrentIdentity.UserID;
                myBasket.ItemID = null;
                myBasket.MovieItemID = MovieID;

                myBasket.ItemDescription = ProdSaveToBasket.MovieTitle;
                myBasket.itemPrice = ProdSaveToBasket.Price;
                myBasket.itemQty = 1;
                myBasket.IsActiveInd = true;

                string prodName = myBasket.ItemDescription;

                double subTotal = (myBasket.itemQty * Price);
                myBasket.TotalPrice = (decimal)subTotal;

                MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Settings.CurrentUserID);
                MELib.Accounts.Account Acc = myAccount.GetItem(Singular.Settings.CurrentUserID);


                double myCurrentalance = (double)(myAccount.FirstAndOnly().Balance);
                //Check The Balance
                if (subTotal <= myCurrentalance)
                {
                    double tempBalance = 0;
                    tempBalance = myCurrentalance - subTotal;
                    try
                    {
                        var i = myBasket.TrySave(typeof(MELib.Basket.BasketList));
                        if (i.Success == true)
                        {
                            sr.Success = true;
                        }
                        
                    }
                    catch(Exception ex)
                    {

                        sr.ErrorText = "Movie Not Added To Cart";
                        ex.ToString();
                    }

                }
                else
                {
                    sr.ErrorText = "Please Fund Your Account. ";
                    //Redirect
                    sr.Success = false;
                }
            }
            catch (Exception e)
            {
                sr.ErrorText = "Product Not Added to Cart.";
                sr.Success = false;
            }

            return sr;
        }
        public static void loadBalance()
        {

            MELib.Accounts.AccountList AccountList = MELib.Accounts.AccountList.GetAccountList();

        }
        [WebCallable(LoggedInOnly = true)]
        public Result CheckOut(MELib.Basket.BasketList uncheckedBasket, MELib.Accounts.Account Account)
        {
            int UserID = Singular.Security.Security.CurrentIdentity.UserID;
            Result sr = new Result();
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
                   MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList((int)ItemNo);
                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem((int)ItemNo);
                    MELib.RO.ROUser Currentuser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();  ///Change

                    int Qty = 0;
                    if (Qty <= ProdSaveToBasket.Quantity)
                    {
                        // MELib.Basket.Basket myBasket = MELib.Basket.Basket.NewBasket();
                        //myBasket.UserID = Currentuser.UserID;
                        // myBasket.ItemID = ProdSaveToBasket.ProductID;
                        //myBasket.ItemDescription = ProdSaveToBasket.ProductName;
                        //myBasket.itemPrice = ProdSaveToBasket.Price;
                        //myBasket.itemQty = Qty;
                        Item.IsActiveInd = false;  //.IsActiveInd = false;
                        //string prodName = myBasket.ItemDescription;
                        int Price = 0;
                        double subTotal = (Qty * Price);
                        MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                        MELib.Accounts.Account Acc = myAccount.GetItem(UserID);
                        //RentalDate = Convert.ToDateTime(DateTime.Today.ToString());

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
                                myTransaction.UserID = 1234;
                                //Acc.Balance -= (decimal)subTotal;

                                var accountList = MELib.Accounts.AccountList.GetAccountList().FirstOrDefault();
                                accountList.Balance -= Item.TotalPrice;

                                //var accountList = MELib.Accounts.AccountList.GetAccountList().FirstOrDefault();

                                //Account.Balance-=(decimal)subTotal;

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

        [WebCallable]
        public static Result SaveAccountList(MELib.Accounts.Account Account)
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

