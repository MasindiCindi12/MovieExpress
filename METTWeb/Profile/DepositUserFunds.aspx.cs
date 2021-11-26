using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular;
using Singular.Web;

namespace MEWeb.Profile
{


    public partial class DepositUserFunds : MEPageBase<DepositUserFundsVM>
    {

    }
    public class DepositUserFundsVM : MEStatelessViewModel<DepositUserFundsVM>
    {

        [Display(Name = "Username", Description = " "),
        Singular.DataAnnotations.DropDownWeb(typeof(MELib.RO.ROUserList), Source = Singular.DataAnnotations.DropDownWeb.SourceType.All, UnselectedText = "Select User", DisplayMember = "UserName", ValueMember = "UserID")]

        public int? UserId { get; set; }
        public MELib.Accounts.Account AccountList { get; set; }

        public MELib.RO.ROUser users { get; set; }
        public MELib.Accounts.AccountList UserAccount { get; set; }

        decimal Balance;
        public decimal Total = 0;
        public DepositUserFundsVM()
        {

        }
        protected override void Setup()
        {
            base.Setup();

        
        }


        [WebCallable(LoggedInOnly = true)]
        public Result GetUserDetails(int UserId)
        {
            Result sr = new Result();
            try
            {

                UserAccount = MELib.Accounts.AccountList.GetAccountList(UserId);
                sr.Data = UserAccount;
                sr.Success = true;
            }
            catch (Exception ex)
            {
                sr.ErrorText = ex.Message.ToString();
            }
            return sr;

        }

        [WebCallable(LoggedInOnly = true)]
        public Result UserInfo(int UserId)
        {
            Result sr = new Result();
            try
            {
                if (UserId > 0)
                {
                    UserAccount = MELib.Accounts.AccountList.GetAccountList(UserId);
                    if (UserAccount != null)
                    {
                        sr.Data = UserAccount;
                        sr.Success = true;
                    }
                    else
                    {
                        sr.ErrorText = "Please Create An Account.";
                        sr.Success = false;
                    }
                }
                else
                {
                    sr.ErrorText = "Please Select The User.";
                    sr.Success = false;
                }

            }
            catch (Exception ex)
            {
                sr.ErrorText = ex.Message.ToString();
            }
            return sr;
        }

        [WebCallable]
        public static Result SaveAccountList(int UserId, MELib.Accounts.AccountList UserAccount , MELib.Accounts.Account Account)
        {

            Result sr = new Result();
            if (UserId > 0)
            {

                MELib.Accounts.AccountList PrevUserAcc = UserAccount;
                if (UserAccount.Count > 0 && UserAccount != null)
                {


                    foreach (MELib.Accounts.Account Item in PrevUserAcc)
                    {
                        var accountList = MELib.Accounts.AccountList.GetAccountList(UserId).FirstOrDefault();

                        accountList.Balance += Item.Balance;

                        var save = accountList.TrySave(typeof(MELib.Accounts.AccountList));

                        if (save.Success == true)
                        {
                            MELib.Transactions.Transaction accountTransaction = MELib.Transactions.Transaction.NewTransaction();
                            accountTransaction.UserID = accountList.UserID;
                            accountTransaction.TransactionTypeID = 1;
                            accountTransaction.Amount = Item.Balance;
                            ///Transraction Type
                            ///
                            MELib.TransactionType.TransactionTypeList AcctransactionType = MELib.TransactionType.TransactionTypeList.GetTransactionTypeList(accountTransaction.TransactionTypeID);
                            MELib.TransactionType.TransactionType AcctransType = AcctransactionType.GetItem(accountTransaction.TransactionTypeID);
                            accountTransaction.Description = AcctransType.TransactionTypeName;
                            accountTransaction.ShipmentMethodID = 1;

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
                    }
                }
                else
                {

                    var accountList = MELib.Accounts.AccountList.GetAccountList(UserId).FirstOrDefault();

                    MELib.Accounts.Account myNewAccount = MELib.Accounts.Account.NewAccount();

                    myNewAccount.UserID = UserId;
                    myNewAccount.AccountTypeID = 1;
                    myNewAccount.Balance = 50;

                    var save = myNewAccount.TrySave(typeof(MELib.Accounts.AccountList));

                    if (save.Success == true)
                    {
                        MELib.Transactions.Transaction accountTransaction = MELib.Transactions.Transaction.NewTransaction();
                        accountTransaction.UserID = accountList.UserID;
                        accountTransaction.TransactionTypeID = 3;
                        accountTransaction.Amount = myNewAccount.Balance;
                        ///Transraction Type
                        ///
                        MELib.TransactionType.TransactionTypeList AcctransactionType = MELib.TransactionType.TransactionTypeList.GetTransactionTypeList(accountTransaction.TransactionTypeID);
                        MELib.TransactionType.TransactionType AcctransType = AcctransactionType.GetItem(accountTransaction.TransactionTypeID);
                        accountTransaction.Description = AcctransType.TransactionTypeName;
                        accountTransaction.ShipmentMethodID = 1;

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
            }
            else
            {
                sr.ErrorText = "Please Select The User.";
                sr.Success = false;
            }


            return sr;
        }



    }

}