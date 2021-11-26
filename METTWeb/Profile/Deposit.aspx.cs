using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;


namespace MEWeb.Profile
{
    
        public partial class Deposit : MEPageBase<DepositVM>
        {
            protected void Page_Load(object sender, EventArgs e)
            {

            }
        }
        public class DepositVM : MEStatelessViewModel<DepositVM>
        {

            public MELib.Accounts.Account myAccount { get; set; }
            public DepositVM()
            { }

            protected override void Setup()
            {
                base.Setup();
                myAccount = MELib.Accounts.Account.NewAccount();
            }
            [WebCallable]
            public static Result SaveAccountList(MELib.Accounts.Account myAccount)
            {
                int UserId = Singular.Security.Security.CurrentIdentity.UserID;

                Result sr = new Result();
                if (UserId > 0)
                {
                    
                        MELib.Accounts.Account myNewAccount = MELib.Accounts.Account.NewAccount();

                        myNewAccount.UserID = myAccount.UserID;
                        myNewAccount.AccountTypeID = 2;
                        myNewAccount.Balance = myAccount.Balance;

                        var save = myNewAccount.TrySave(typeof(MELib.Accounts.AccountList));

                if (save.Success == true)
                {
                    MELib.Transactions.Transaction accountTransaction = MELib.Transactions.Transaction.NewTransaction();
                    accountTransaction.UserID = myAccount.UserID;
                    accountTransaction.TransactionTypeID = 2;
                    accountTransaction.Amount = myNewAccount.Balance;
                    ///Transraction Type
                    ///
                    MELib.TransactionType.TransactionTypeList AcctransactionType = MELib.TransactionType.TransactionTypeList.GetTransactionTypeList(accountTransaction.TransactionTypeID);
                    MELib.TransactionType.TransactionType AcctransType = AcctransactionType.GetItem(accountTransaction.TransactionTypeID);
                    accountTransaction.Description = AcctransType.TransactionTypeName;
                    accountTransaction.ShipmentMethodID = 0;

                    var iAccSave = accountTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
                    if (iAccSave.Success == true)
                    {
                        sr.Success = true;
                    }
                    else
                    {
                        sr.ErrorText = "Transaction Not Created";
                        sr.Success = false;
                    }
                    return new Singular.Web.Result() { Success = true };
                }
                else
                {
                    sr.ErrorText = "User Funds Not Updated.";
                    sr.Success = false;
                }
                        return new Singular.Web.Result() { Success = true };
                }
                else
                {
                    sr.ErrorText = "User Not Found!.";
                    sr.Success = false;
                }


                return sr;
            }




        }
    
}