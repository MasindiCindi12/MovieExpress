using System;
using System.ComponentModel.DataAnnotations;
using System.Web;
using Singular.Web;

namespace MEWeb.Movies
{
    public partial class Movies : MEPageBase<MoviesVM>
  {
  }
  public class MoviesVM : MEStatelessViewModel<MoviesVM>
  {
    public MELib.Movies.MovieList MovieList { get; set; }

    // Filter Criteria
    public DateTime ReleaseFromDate { get; set; }
    public DateTime ReleaseToDate { get; set; }

    /// <summary>
    /// Gets or sets the Movie Genre ID
    /// </summary>
    [Singular.DataAnnotations.DropDownWeb(typeof(MELib.RO.ROMovieGenreList), UnselectedText = "Select", ValueMember = "MovieGenreID", DisplayMember = "Genre")]
    [Display(Name = "Genre")]
    public int? MovieGenreID { get; set; }
        public MELib.Security.UserList UserDetails { get; set; }
        public MELib.Accounts.Account UserAccount { get; set; }
        public MoviesVM()
    {

    }
        protected override void Setup()
        {
            base.Setup();

            MovieList = MELib.Movies.MovieList.GetMovieList();
            UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));
            UserAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstAndOnly();
        }

        [WebCallable(LoggedInOnly = true)]
        public string RentMovie(int MovieID)
        { 
            var url = VirtualPathUtility.ToAbsolute("~/Movies/Movie.aspx?MovieID=" + HttpUtility.UrlEncode(MovieID.ToString()));;
            return url;
        }

        [WebCallable(LoggedInOnly = true)]
        public Result AddToCart(int MovieID,  double Price, MELib.Movies.Movie Movie)
        {

            //UserID
            int UserID = Singular.Security.Security.CurrentIdentity.UserID;
            Result sr = new Result();
            try
            {

                MELib.Movies.MovieList SaveProd = MELib.Movies.MovieList.GetMovieList(MovieID);
                MELib.Movies.Movie ProdSaveToBasket = SaveProd.GetItem(MovieID);


                var BASKY = MELib.Basket.BasketList.GetBasketList(UserID);

                MELib.Basket.Basket myBasket = MELib.Basket.Basket.NewBasket();
                myBasket.UserID = UserID;
                myBasket.ItemID = ProdSaveToBasket.MovieID;
                myBasket.ItemDescription = ProdSaveToBasket.MovieTitle;
                myBasket.itemPrice = ProdSaveToBasket.Price;

                myBasket.IsActiveInd = true;
                string prodName = myBasket.ItemDescription;

                decimal subTotal = (1 * (decimal)Price);
                myBasket.TotalPrice = (decimal)subTotal;

                MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserID);
                MELib.Accounts.Account Acc = myAccount.GetItem(UserID);


                decimal myCurrentalance = Acc.Balance;
                //Check The Balance
                if (subTotal <= myCurrentalance)
                {
                    decimal tempBalance = 0;
                    tempBalance = myCurrentalance - subTotal;


                    Acc.Balance = -(subTotal);

                    var i = myBasket.TrySave(typeof(MELib.Basket.BasketList));
                    if (i.Success == true)
                    {
                        return new Singular.Web.Result()
                        { Success = true };


                    }
                    else
                    {
                        return new Singular.Web.Result()
                        { Success = false };
                    }

                    sr.Success = true;

                }
                else
                {
                    sr.ErrorText = "Please Fund Your Account. ";
                    //Redirect
                    sr.Success = false;
                }


                // sr.Success = true;
            }
            catch (Exception e)
            {
                sr.ErrorText = "Product Not Added to Cart.";
                sr.Success = false;
            }

            return sr;
        }


        [WebCallable]
    public static Result WatchMovie(int MovieID)
    {
      Result sr = new Result();
      try
      {

                try
                {
                    sr.Data = MELib.Movies.MovieList.GetMovieList(MovieID);
                    sr.Success = true;
                }
                catch (Exception e)
                {
                    WebError.LogError(e, "Page: LatestReleases.aspx | Method: FilterMovies", $"(int MovieID, ({MovieID})");
                    sr.Data = e.InnerException;
                    sr.ErrorText = "Could not filter movies by category.";
                    sr.Success = false;
                }
                sr.Success = true;
      }
      catch (Exception e)
      {
        sr.Data = e.InnerException;
        sr.Success = false;
      }
      return sr;
    }

    [WebCallable]
    public Result FilterMovies(int MovieGenreID, int ResetInd)
    {
            Result sr = new Result();
            try
            {
                if (ResetInd == 0)
                {
                    MELib.Movies.MovieList MovieList = MELib.Movies.MovieList.GetMovieList(MovieGenreID);
                    sr.Data = MovieList;
                }
                else
                {
                    MELib.Movies.MovieList MovieList = MELib.Movies.MovieList.GetMovieList();
                    sr.Data = MovieList;
                }
                sr.Success = true;
            }
            catch (Exception e)
            {
                WebError.LogError(e, "Page: LatestReleases.aspx | Method: FilterMovies", $"(int MovieGenreID, ({MovieGenreID})");
                sr.Data = e.InnerException;
                sr.ErrorText = "Could not filter movies by category.";
                sr.Success = false;
            }
            return sr;
        }
    }
}

