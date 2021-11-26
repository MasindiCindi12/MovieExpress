using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular;
using Singular.Web;



namespace MEWeb.Account
{
    public partial class Home : MEPageBase<HomeVM>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
        }
    }
    public class HomeVM : MEStatelessViewModel<HomeVM>
    {
        // Declare your page variables/properties here
        public bool FoundUserMoviesInd { get; set; }

        public bool FoundUserProductInd { get; set; }
        public string LoggedInUserName { get; set; }
//
       // public MELib.Movies.UserMovieList UserMovieList { get; set; }
        public MELib.Movies.MovieList UserMovieList { get; set; }

        public MELib.Products.ProductList ProductList { get; set; }

        public MELib.Basket.Basket myBasket { get; set; }

        public MELib.Movies.MovieList MovieList { get; set; }


        
         //Gettting User data
        public MELib.Security.UserList UserDetails { get; set; }

        // Delivery Method 
        [Singular.DataAnnotations.DropDownWeb(typeof(MELib.Shipment.ShipmentMethodList), Source = Singular.DataAnnotations.DropDownWeb.SourceType.All,
           UnselectedText = "Select Shipment ", DisplayMember = "ShipmentMethodName", ValueMember = "ShipmentMethodID")]
        [Display(Name = "Shipment Method")]
        public int? ShipmentMethodID { get; set; }
        public MELib.Accounts.AccountList UserAccountList { get; set; }
        public MELib.Accounts.Account UserAccount { get; set; }

        public int UserId;
        public MELib.RO.ROUser users { get; set; }
        public decimal Total = 0;
        
        public HomeVM()
        { }
        protected override void Setup()
        {
            base.Setup();
            Total = Math.Round(MELib.Basket.BasketList.GetBasketList().Sum(x => x.TotalPrice), 2);

            UserMovieList = MELib.Movies.MovieList.GetMovieList();
            //UserMovieList = MELib.Movies.UserMovieList.GetUserMovieList();
            //users = MELib.RO.ROUserList.GetROUserList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();

            MovieList = MELib.Movies.MovieList.GetMovieList();



            ProductList = MELib.Products.ProductList.GetProductList();
            UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));

        
            UserAccountList = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID);
            // UserAccount = UserAccountList.();
            UserAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();

            myBasket = MELib.Basket.BasketList.GetBasketList((Singular.Security.Security.CurrentIdentity.UserID)).FirstOrDefault();
            
            LoggedInUserName = Singular.Security.Security.CurrentIdentity.UserName;


            
        }

        [WebCallable(LoggedInOnly = true)]
        public string RentMovie(int MovieID)
        {
            var url = VirtualPathUtility.ToAbsolute("~/Movies/Movie.aspx?MovieID=" + HttpUtility.UrlEncode(MovieID.ToString()));
            return url;
        }


        [WebCallable(LoggedInOnly = true)]
        public string ViewProduct(int ProductID)
        {
            var url = VirtualPathUtility.ToAbsolute("~/Products/Product.aspx?ProductID=" + HttpUtility.UrlEncode(ProductID.ToString()));
            return url;
        }


        [WebCallable]
        public static  void loadBalance()
        {

            MELib.Accounts.AccountList AccountList = MELib.Accounts.AccountList.GetAccountList();

        }

        [WebCallable]
        public static void loadQuantity()
        {

            MELib.Products.ProductList ProductList = MELib.Products.ProductList.GetProductList();

        }

        [WebCallable]
        public static Result SaveAccountList(MELib.Accounts.Account Account)
        {
            if (Account.Balance > 0)
            {
                var accountList = MELib.Accounts.AccountList.GetAccountList(Account.UserID).FirstOrDefault();

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
                return new Singular.Web.Result() { ErrorText = " You can not add any amount less than R1 ", Success = false };
             
            }
            loadBalance();
        }

      

    }
}


