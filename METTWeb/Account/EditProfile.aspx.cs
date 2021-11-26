using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;

namespace MEWeb.Account
{

    public partial class Profile : MEPageBase<ProfileVM>
    {
    }
    public class ProfileVM : MEStatelessViewModel<ProfileVM>
    {
        public MELib.Accounts.AccountList AccountList { get; set; }



      public int ? AccountID { get; set; }
        public ProfileVM()
        {

        }

        protected override void Setup()
        {
            base.Setup();

            
            AccountList = MELib.Accounts.AccountList.GetAccountList();
        }

        public int? UserID { get; set; }
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }
        public string ProductImageURL { get; set; }
        public double Price { get; set; }

       

    }
}