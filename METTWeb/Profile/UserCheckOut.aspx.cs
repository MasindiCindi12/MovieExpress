using Singular.Web;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace MEWeb.Profile
{

    public partial class UserCheckOut : MEPageBase<UserCheckOutVM>
    {

    }
    public class UserCheckOutVM : MEStatelessViewModel<UserCheckOutVM>
    {
        [Display(Name = "Shipment Method", Description = " "),
        Singular.DataAnnotations.DropDownWeb(typeof(MELib.Shipment.ShipmentMethodList), Source = Singular.DataAnnotations.DropDownWeb.SourceType.All, UnselectedText = "Select Shipment Method", DisplayMember = "ShipmentMethodName", ValueMember = "ShipmentMethodID")]
        public int? ShipmentMethodID { get; set; }


        public decimal Total = 0;

        [Display(Name = "Username", Description = " "),
        Singular.DataAnnotations.DropDownWeb(typeof(MELib.RO.ROUserList), Source = Singular.DataAnnotations.DropDownWeb.SourceType.All, UnselectedText = "Select User", DisplayMember = "UserName", ValueMember = "UserID")]

        public int? UserId { get; set; }

        public MELib.Accounts.AccountList UserAccount { get; set; }
        public MELib.Basket.BasketList myBasket { get; set; }

        public MELib.RO.ROUser users { get; set; }

        public UserCheckOutVM()
        {

        }
        protected override void Setup()
        {
            base.Setup();
          
        }

        [WebCallable(LoggedInOnly = true)]
        public decimal GrandTotal(int UserId)
        {
            //Result sr = new Result();
            try
            {
                Total = Math.Round(MELib.Basket.BasketList.GetBasketList(UserId).Sum(x => x.TotalPrice), 2);
                //sr.Data = Total;
            }
            catch(Exception ex)
            {
                ex.ToString();
            }
            return Total;
        }
        [WebCallable(LoggedInOnly = true)]
        public Result UserInfo(int UserId)
        {

            Result sr = new Result();
            try
            {if (UserId > 0)
                {
                    MELib.Basket.BasketList myBasket = MELib.Basket.BasketList.GetBasketList(UserId);
                    if (myBasket != null)
                    {
                        sr.Data = myBasket;
                        sr.Success = true;
                    }
                    else
                    {
                        sr.ErrorText = "Please Add Items To Your Cart.";
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
        [WebCallable(LoggedInOnly = true)]
        public Result CheckOut(decimal Total,int UserId,  int shipmentMethodID, MELib.Basket.BasketList uncheckedBasket, MELib.Accounts.Account Account)
        {

            int shipID = shipmentMethodID;
            Result sr = new Result();
            if (shipID > 0)
            {
               

                if (uncheckedBasket.Count > 0)
                {
                    try
                    {
                        var uncheckedBasketList = uncheckedBasket;

                        MELib.Basket.BasketList unbasket = uncheckedBasketList;
                        int ProductID = 0;
                        int? ItemNo = 0;
                        var accountList = MELib.Accounts.AccountList.GetAccountList(UserId).FirstOrDefault();

                        MELib.Transactions.Transaction myTransaction = MELib.Transactions.Transaction.NewTransaction();
                        MELib.Accounts.AccountList myAccount = MELib.Accounts.AccountList.GetAccountList(UserId);
                        MELib.Accounts.Account Acc = myAccount.GetItem(UserId);
                        decimal totalPrice = Total;
                        if (accountList.Balance >= totalPrice)
                        {
                            MELib.Shipment.ShipmentMethodList myShipment = MELib.Shipment.ShipmentMethodList.GetShipmentMethodList(shipmentMethodID);
                            MELib.Shipment.ShipmentMethod processingShipmentMethod = myShipment.GetItem(shipmentMethodID);

                            string deliveryMethod = processingShipmentMethod.ShipmentMethodName;
                            decimal deliveryPrice = processingShipmentMethod.Price;

                            System.Text.StringBuilder myTransactionBuilder = new System.Text.StringBuilder();
                            foreach (MELib.Basket.Basket Item in unbasket)
                            {

                                if (Item.TotalPrice <= accountList.Balance)
                                {
                                    ItemNo = Item.ItemID;
                                    ProductID = Item.BasketID;
                                    MELib.RO.ROProductList SaveProd = MELib.RO.ROProductList.GetProductList((int)ItemNo);
                                    MELib.RO.ROProduct ProdSaveToBasket = SaveProd.GetItem((int)ItemNo);
                                    MELib.RO.ROUser Currentuser = MELib.RO.ROUserList.GetROUserList().FirstOrDefault();  ///Change

                                    var productList = MELib.Products.ProductList.GetProductList(ProdSaveToBasket.ProductID);   /// we must still get project by id
                                    MELib.Products.Product product = productList.GetItem(ProdSaveToBasket.ProductID);
                                    product.Quantity -= Item.itemQty;

                                    var save0 = product.TrySave(typeof(MELib.Products.ProductList));
                                    if (save0.Success == true)
                                    {                            
                                        sr.Success = true;
                                    }
                                    else
                                    {
                                        sr.Success = false;
                                    }
                                    Item.IsActiveInd = false;
                                    var b = Item.TrySave(typeof(MELib.Basket.BasketList));

                                    myTransaction.TransactionTypeID = 1;
                                    myTransaction.UserID = UserId;

                                    sr.Success = true;
                                }
                                myTransaction.Description += Item.ItemDescription + " @ R " + Item.itemPrice + " each  x " + Item.itemQty + " = R " + Item.TotalPrice + "\r\n" + "\n";
                                myTransaction.Description += Environment.NewLine;

                                myTransaction.Amount += (decimal)Item.TotalPrice;
                            }

                            myTransaction.Description += "\r\n" + "\n" + "Delivery Method " + deliveryMethod;
                            myTransaction.Amount += deliveryPrice;

                            var SaveResult = myTransaction.TrySave(typeof(MELib.Transactions.TransactionList));
                            if (SaveResult.Success)
                            {
                                accountList.Balance -= myTransaction.Amount;
                                var Save = accountList.TrySave(typeof(MELib.Accounts.AccountList));
                                if (Save.Success)
                                {
                                    sr.Data = MELib.Basket.BasketList.GetBasketList(UserId);
                                    sr.Data = SaveResult.SavedObject;
                                    sr.Success = true;
                                }
                                else
                                {
                                    sr.ErrorText = "Account not Updated";
                                    sr.Success = false;
                                }
                            }
                            else
                            {
                                sr.ErrorText = "Transaction not Successful";
                                sr.Success = false;
                            }

                        }
                        else
                        {
                            sr.ErrorText = "Fund Your Account.";
                            sr.Success = false;
                        }
                    }
                    catch (Exception e)
                    {
                        sr.ErrorText = "Product Not Added to Cart.";
                        e.ToString();
                    }
                }

                else
                {
                    sr.ErrorText = "Please Items Load to Cart.";
                    sr.Success = false;
                }
            }
            else
            {
                sr.ErrorText = "Please Select a shipment method.";
                sr.Success = false;
            }
            return sr;
        }

        //Updating The Cart 
        [WebCallable]
        public Result SaveCartList(int UserId, MELib.Basket.BasketList myBasket)
        {
            Result sr = new Result();
            if (UserId > 0)
            {
                if (myBasket.Count > 0)
                {
                    if (myBasket.IsValid)
                    {

                        myBasket = MELib.Basket.BasketList.GetBasketList(UserId);
                        var SaveResult = myBasket.TrySave();
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
                        sr.ErrorText = myBasket.GetErrorsAsHTMLString();
                        return sr;
                    }
                }
                else
                {
                    sr.ErrorText = "The Users Cart Must Contain Items.";
                    return sr;
                }
            }
            else
            {
                sr.ErrorText = "Please Select User";
                return sr;
            }

        }

    }

}