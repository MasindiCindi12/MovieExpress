using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;


namespace MEWeb.Account
{
     
        public partial class NewUserRegistrations : MEPageBase<NewUserRegistrationsVM>
        {

        }


        public class NewUserRegistrationsVM : MEStatelessViewModel<NewUserRegistrationsVM>
        {

            public MELib.TempUser.TempUser NewUser { get; set; }
            public NewUserRegistrationsVM()
            { }

            protected override void Setup()
            {
                base.Setup();
                NewUser = MELib.TempUser.TempUser.NewTempUser();

            }

        [WebCallable(LoggedInOnly = true)]
        public string DepositeFundsPage()
        {
            var url = VirtualPathUtility.ToAbsolute("~/Profile/DepositFunds.aspx"); ;
           
            return url;
        }

        [WebCallable(LoggedInOnly = true)]
            public Result NewUserRegistration(string FirstName, string LastName, string UserName, string EmailAddress, string ContactNo, string Password)
      
            {

             string salt="Created By Masindi Sekhwari";

                Result sr = new Result();
            try
            {
                MELib.TempUser.TempUser myNewUserAccount = MELib.TempUser.TempUser.NewTempUser();
                myNewUserAccount.FirstName = Encoding.ASCII.GetBytes(FirstName);
                myNewUserAccount.LastName = Encoding.ASCII.GetBytes(LastName);
                myNewUserAccount.UserName = UserName;
                myNewUserAccount.EmailAddress = EmailAddress;
                myNewUserAccount.ContactNumber = ContactNo;
                myNewUserAccount.Password = Encoding.ASCII.GetBytes(Password);
                myNewUserAccount.Salt = myNewUserAccount.Password;
                myNewUserAccount.PasswordChangeDate = Convert.ToDateTime(DateTime.Today.ToString());

                var save = myNewUserAccount.TrySave(typeof(MELib.TempUser.TempUserList));

                if (save.Success == true)
                {
                    sr.Data = DepositeFundsPage();
                    sr.Success = true;
                }
                else
                {
                    sr.ErrorText = "User Not Added.";
                    sr.Success = false;
                }
            }
            catch (Exception Ex)
            {
                sr.ErrorText = "User Not Added." + Ex.ToString();
                sr.Success = false;
            }
                return sr;
            }
        }
    }