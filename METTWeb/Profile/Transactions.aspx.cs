using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;

namespace MEWeb.Profile
{
  public partial class Transactions : MEPageBase<TransactionsVM>
  {
  }
  public class TransactionsVM : MEStatelessViewModel<TransactionsVM>
  {
        public MELib.Transactions.TransactionList TransactionList { get; set; }
    public TransactionsVM()
    {

    }
    protected override void Setup()
    {
      base.Setup();
            TransactionList = MELib.Transactions.TransactionList.GetTransactionList(Singular.Security.Security.CurrentIdentity.UserID);
            MELib.Transactions.Transaction myTransaction = TransactionList.GetItem(Singular.Security.Security.CurrentIdentity.UserID);

           
    }


        [WebCallable(LoggedInOnly = true)]
        public Result AddToCart(int ProductID, double TotalAMount, int Qty,double Price, DateTime RentalDate)
        {
            int UserID = Singular.Security.Security.CurrentIdentity.UserID;
            Result sr = new Result();

            if (Qty > 0)
            {
                try
                {

                    MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList(ProductID);
                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem(ProductID);
                    MELib.RO.ROUser Currentuser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();  ///Change

                    //Check the Quantity of products available
                    if (Qty <= ProdSaveToBasket.Quantity)
                    {
                        MELib.Basket.Basket myBasket = MELib.Basket.Basket.NewBasket();
                        myBasket.UserID = Currentuser.UserID;
                        myBasket.ItemID = ProdSaveToBasket.ProductID;
                        myBasket.ItemDescription = ProdSaveToBasket.ProductName;
                        myBasket.itemPrice = ProdSaveToBasket.Price;
                        myBasket.itemQty = Qty;
                        myBasket.IsActiveInd = true;
                        string prodName = myBasket.ItemDescription;


                        //Calculating the total cost

                        MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(Singular.Security.Security.CurrentIdentity.UserID);

                        //Get the user account
                        MELib.Accounts.Account Acc = myAccount.GetItem(Singular.Security.Security.CurrentIdentity.UserID);

                       
                        var i = myBasket.TrySave(typeof(MELib.Basket.BasketList));
                        if (i.Success == true)
                        {
                            sr.Data = myBasket;   //// Hey logic here
                            sr.Success = true;
                        }
                        else
                        {
                            sr.ErrorText = "Please Fund Your Account. ";
                            var url = $"../Profile/DepositeFunds.aspx";
                            sr.Success = false;
                        }

                    }
                    else
                    {

                        sr.ErrorText = "Available Items for the selected products are less than what you request.";
                        sr.Success = false;
                    }
                    sr.Success = true;
                }
                catch (Exception ex)
                {
                    sr.ErrorText = "Product Not Added to Cart." + ex.ToString();
                    sr.Success = false;
                }
            }
            else
            {
                sr.ErrorText = "You can not add 0 or less items to cart.";
                sr.Success = false;
            }
            return sr;
        }






    }
}

