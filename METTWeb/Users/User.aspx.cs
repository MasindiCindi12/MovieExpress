using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;
using Singular.Web.Security;

namespace MEWeb.Users
{


    public partial class User : MEPageBase<UserVM>
    {
    }
    public class UserVM : MEStatelessViewModel<UserVM>
    {


        public LoginDetails LoginDetails { get; set; }
        public bool ShowForgotPasswordInd { get; set; }
        public User User  { get; set; }
        public UserVM()
        {

        }
        protected override void Setup()
        {
            base.Setup();
            this.ShowForgotPasswordInd = false;
            this.LoginDetails = new LoginDetails();
        }
    }
    
}