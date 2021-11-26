using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;
using Csla;
using Csla.Serialization;
using Csla.Data;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using Singular;
using System.Data;
using System.Data.SqlClient;
using MELib.Accounts;

namespace MEWeb.Profile
{
    public partial class DepositFunds : MEPageBase<DepositFundsVM>
    {
    }
    public class DepositFundsVM : MEStatelessViewModel<DepositFundsVM>
    {

        
        public MELib.Accounts.Account AccountList { get; set; }

        public MELib.Transactions.Transaction TransactionList { get; set; }


        public MELib.Products.Product ProductList { get; set; }
        public MELib.RO.ROUser users { get; set; }
        public MELib.Security.UserList UserDetails { get; set; }
        public int UserId { get; set; }
        public DepositFundsVM()
        {

        }
        protected override void Setup()
        {
            base.Setup();
            users = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();
            // UserList = MELib.Security.UserList.GetUserList(UserId);
            AccountList = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID).FirstOrDefault();
            ProductList = MELib.Products.ProductList.GetProductList().FirstOrDefault();

            UserDetails = MELib.Security.UserList.GetUserList((Singular.Security.Security.CurrentIdentity.UserID));


        }

      
        [WebCallable]
        public static Result SaveAccountList(MELib.Accounts.Account  Account)
        {
            Result sr = new Result();
            if (Account.Balance > 0)
            {
                var accountList = MELib.Accounts.AccountList.GetAccountList(Account.UserID).FirstOrDefault();
              
                accountList.Balance += Account.Balance;

                var save = accountList.TrySave(typeof(MELib.Accounts.AccountList));

                if (save.Success == true)
                {

                    MELib.Transactions.Transaction myTransaction = MELib.Transactions.Transaction.NewTransaction();
                    myTransaction.UserID = accountList.UserID;
                    myTransaction.TransactionTypeID = 2;
                    myTransaction.Amount = Account.Balance;
                    MELib.TransactionType.TransactionTypeList transactionType = MELib.TransactionType.TransactionTypeList.GetTransactionTypeList(myTransaction.TransactionTypeID);
                    MELib.TransactionType.TransactionType transType = transactionType.GetItem(myTransaction.TransactionTypeID);
                    myTransaction.Description = transType.TransactionTypeName;
                    myTransaction.ShipmentMethodID = 0;
                    var iSave = myTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
                    if (iSave.Success == true)
                    {
                        sr.Success = true;


                    }
                    else
                    {
                        sr.ErrorText = "Transaction Not Created";
                        sr.Success = false;
                    }
                }
                else
                {
                    sr.ErrorText = "Account Not Funded.";
                    sr.Success = false;
                }
            }
            else
            {

                sr.ErrorText = "You Can't Fund Your Account With Less than R1.";
                sr.Success = false;
            }
           
            return sr;
        }

       


       

       
    

    }
}

