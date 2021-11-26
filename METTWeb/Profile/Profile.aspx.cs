using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;

namespace MEWeb.Profile
{
  public partial class Profile : MEPageBase<ProfileVM>
  {
  }
  public class ProfileVM : MEStatelessViewModel<ProfileVM>
  {

        public MELib.Security.User User { get; set; }

        public int UserId { get; set; }
        public MELib.Security.User UserList { get; set; }
        public MELib.RO.ROUser EditUser { get; set; }
        public ProfileVM()
    {

    }
    protected override void Setup()
    {
      base.Setup();
            UserList = MELib.Security.UserList.GetUserList().FirstOrDefault();
            EditUser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();
        }
  }
}

