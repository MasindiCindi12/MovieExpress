using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web.Data;
using MELib.RO;
using MELib.Security;
using Singular;
using Singular.Web;

namespace MEWeb.Profile
{


    public partial class BasicUser : MEPageBase<BasicUserVM>
    {

    }
    public class BasicUserVM : MEStatelessViewModel<BasicUserVM>
    {
        public MELib.Security.UserList UserListing { get; set; }
        public MELib.RO.ROUser EditUser { get; set; }
        public MELib.Security.User EditingUser { get; set; }
        public MELib.Security.UserList UserList { get; set; }
        public BasicUserVM()
        {
        }

        protected override void Setup()
        {
            base.Setup();
            UserList = MELib.Security.UserList.GetUserList(Singular.Security.Security.CurrentIdentity.UserID);
            EditUser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();

           UserListing  = MELib.Security.UserList.GetUserList();
        }


        [WebCallable]
        public Result UpdateProfile(MELib.Security.UserList UserList)
        {
            Result sr = new Result();
            if (UserList.IsValid)
            {
                var SaveResult = UserList.TrySave();
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
                sr.ErrorText = UserList.GetErrorsAsHTMLString();
                return sr;
            }
        }



        [WebCallable]
        public Result SaveUser(string FirstName, string LastName, string Username, string contactNo, string EmailAddress, MELib.Security.UserList UserList )
        {


            Result sr = new Result();
            if (UserList.IsValid)
            {
               

                var SaveResult = UserList.TrySave();
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
                sr.ErrorText = UserList.GetErrorsAsHTMLString();
                return sr;
            }
        }


        //[WebCallable(Roles = new string[] { "Security.Manage Users" })]
        //public static Result SaveUser(MELib.Security.User UserListing)
        //{
        //    //if (user.SecurityGroupUserList.Count == 0)
        //    //{
        //    //    //add a default security group of General User
        //    //    SecurityGroupUser securityGroupUser = SecurityGroupUser.NewSecurityGroupUser();
        //    //    securityGroupUser.SecurityGroupID = ROSecurityGroupList.GetROSecurityGroupList(true).FirstOrDefault(c => c.SecurityGroup == "General User")?.SecurityGroupID;
        //    //    user.SecurityGroupUserList.Add(securityGroupUser);
        //    //}

        //    //user.LoginName = user.EmailAddress;

        //    Result results = new Singular.Web.Result();
        //    Result Saveresults = user.SaveUser(user);
        //    MELib.Security.User SavedUser = (MELib.Security.User)Saveresults.Data;

        //    if (SavedUser != null)
        //    {
        //        results.Success = true;
        //        results.Data = SavedUser;
        //    }
        //    else
        //    {
        //        results.Success = false;
        //        results.ErrorText = Saveresults.ErrorText;
        //    }
        //    return results;
        //}




    }

}