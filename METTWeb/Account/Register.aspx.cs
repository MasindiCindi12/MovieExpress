using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;

namespace MEWeb.Account
{
    public partial class Register : MEPageBase<RegisterVM>
    {

    }
    public class RegisterVM : MEStatelessViewModel<RegisterVM>
    {

        public MELib.RO.ROUserList AccountList { get; set; }
        public MELib.Movies.Movie EditMovie { get; set; }

        public int CategoryID { get; set; }

        public RegisterVM()
        { }

        protected override void Setup()
        {
            base.Setup();
            AccountList = MELib.RO.ROUserList.GetROUserList();
            EditMovie = MELib.Movies.MovieList.GetMovieList().FirstOrDefault();
        }
    }
 }