<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="MEWeb.Products.Products" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

  <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <%
        using (var h = this.Helpers)
        {
            var MainContent = h.DivC("row pad-top-10");
            {
                var MainContainer = MainContent.Helpers.DivC("col-md-12 p-n-lr");
                {
                    var PageContainer = MainContainer.Helpers.DivC("tabs-container");
                    {
                        var PageTab = PageContainer.Helpers.TabControl();
                        {
                            PageTab.Style.ClearBoth();
                            PageTab.AddClass("nav nav-tabs");
                            var ContainerTab = PageTab.AddTab("Available Products");

                            var RowContentDiv = ContainerTab.Helpers.DivC("row");
                            {

                                var RowColMain = RowContentDiv.Helpers.DivC("col-md-12");
                                {
                                    RowColMain.Helpers.HTML().Heading2("Snacks Express");
                                    RowColMain.Helpers.HTMLTag("p").HTML = "On your dashboard below you will see the most recent activities performed on your account.";
                                }

                                var RowColMain1 = RowContentDiv.Helpers.DivC("col-md-12");
                                {

                                    RowColMain1.Helpers.HTMLTag("br/");

                                }
                                var ColContentDiv = RowContentDiv.Helpers.DivC("col-md-8");
                                {
                                    var ProductsDiv = ColContentDiv.Helpers.BootstrapTableFor<MELib.Products.Product>((c) => c.ProductList, false, false, "");
                                    {

                                        var FirstRow = ProductsDiv.FirstRow;
                                        {
                                            var ProductName = FirstRow.AddColumn("Product Name");
                                            var ProductNameText = ProductName.Helpers.Span(c => c.ProductName);
                                            ProductNameText.Style.Width = "300px";
                                        }
                                        var ProductDescription = FirstRow.AddColumn("Description");
                                        {
                                            var ProductDescriptionText = ProductDescription.Helpers.Span(c => c.ProductDescription);
                                            ProductDescriptionText.Style.Width = "600px";
                                              ProductDescription.Style.Width = "600px";
                                        }
                                        var ProductPrice = FirstRow.AddColumn("Price Rs");
                                        {

                                            ProductPrice.Helpers.HTML("R ");
                                            var ProductDescriptionText = ProductPrice.Helpers.Span(c => c.Price);
                                             ProductDescriptionText.Style.Width = "100px";
                                        }

                                        var ProductQty = FirstRow.AddColumn(" Available Quantity");
                                        {
                                            var ProductPriceText = ProductQty.Helpers.EditorFor(c => c.Quantity);
                                               ProductPriceText.Style.Width = "60px";
                                        }


                                        var ProductAction = FirstRow.AddColumn("");
                                        {
                                            var BuyBtn = ProductAction.Helpers.Button("Add To Cart", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                            {

                                                BuyBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "AddToCart($data)");
                                                BuyBtn.AddClass("btn btn-success btn-outline");

                                            }
                                        }




                                    }
                                }

                                var RowCol = RowContentDiv.Helpers.DivC("col-md-4");
                                {

                                    var CardDiv = RowCol.Helpers.DivC("ibox float-e-margins paddingBottom");
                                    {
                                        var CardTitleDiv = CardDiv.Helpers.DivC("ibox-title");
                                        {
                                            CardTitleDiv.Helpers.HTML("<i class='fa-lg fa-fw pull-left'></i>");
                                            CardTitleDiv.Helpers.HTML().Heading5("Profile");
                                        }
                                        var CardTitleToolsDiv = CardTitleDiv.Helpers.DivC("ibox-tools");
                                        {
                                            var aToolsTag = CardTitleToolsDiv.Helpers.HTMLTag("a");
                                            aToolsTag.AddClass("collapse-link");
                                            {
                                                var iToolsTag = aToolsTag.Helpers.HTMLTag("i");
                                                iToolsTag.AddClass("fa fa-chevron-up");
                                            }
                                        }
                                        var ContentDiv = CardDiv.Helpers.DivC("ibox-content");
                                        {
                                            var FarRowContentDiv = ContentDiv.Helpers.DivC("row");
                                            {
                                                var LeftColContentDiv = FarRowContentDiv.Helpers.DivC("col-md-12 text-left");
                                                {

                                                    var UserDiv = LeftColContentDiv.Helpers.With<MELib.Security.UserList>(c => c.UserDetails);
                                                    {
                                                        UserDiv.Helpers.Span("Username:  ").Style.FontSize = "17px";
                                                        UserDiv.Helpers.Span(c => c.FirstOrDefault().LoginName).Style.FontSize = "17px";
                                                        UserDiv.Helpers.HTMLTag("br/");
                                                    }

                                                    var ProfileDiv = LeftColContentDiv.Helpers.With<MELib.Accounts.Account>(c => c.UserAccount);
                                                    {

                                                        ProfileDiv.Helpers.Span("Available Balance :  R").Style.FontSize = "20px";
                                                        ProfileDiv.Helpers.Span(c => c.Balance).Style.FontSize = "20px";


                                                        ProfileDiv.Helpers.HTMLTag("br/");
                                                      

                                                       

                                                    }
                                                    var RightColContentDiv = LeftColContentDiv.Helpers.DivC("col-md-12 text-center");
                                                    {
                                                        
                                                    }

                                                    var RightRowContentDiv = ContentDiv.Helpers.DivC("row");
                                                    {
                                                        var FarRightColContentDiv = RightRowContentDiv.Helpers.DivC("col-md-12");
                                                        {
                                                            FarRightColContentDiv.Helpers.HTMLTag("hr");
                                                            FarRightColContentDiv.Helpers.HTML().Heading2("Cart Summary");
                                                            FarRightColContentDiv.Helpers.HTMLTag("br/");


                                                            var cart = FarRightColContentDiv.Helpers.BootstrapTableFor<MELib.Basket.Basket>((c) => c.myBasket, false, true, "");
                                                            {
                                                                var FirstRow = cart.FirstRow;
                                                                {
                                                                    var ProductName = FirstRow.AddColumn("Product");
                                                                    {
                                                                        var ProductNameText = ProductName.Helpers.Span(c => c.ItemDescription);
                                                                        ProductName.Style.Width = "100px";
                                                                    }
                                                                    var ProductPrice = FirstRow.AddColumn("Price");
                                                                    {

                                                                        ProductPrice.Helpers.Span("R");
                                                                        var ProductPriceText = ProductPrice.Helpers.Span(c => c.itemPrice);
                                                                    }
                                                                    var ProductQty = FirstRow.AddColumn("Quantity");
                                                                    {
                                                                        var ProductQtyText = ProductQty.Helpers.EditorFor(c => c.itemQty);
                                                                        ProductQtyText.Style.Width = "50px";
                                                                    }

                                                                    var ProductTotal = FirstRow.AddColumn("Total");
                                                                    {

                                                                        ProductTotal.Helpers.Span("R");
                                                                        var ProductTotalText = ProductTotal.Helpers.Span(c => c.TotalPrice);
                                                                    }
                                                                    //var Remove = FirstRow.AddColumn();
                                                                    //{
                                                                    //    var RemoveBtn = Remove.Helpers.Button("Remove", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                                    //    {
                                                                    //        RemoveBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "CheckOut($data)");
                                                                    //        RemoveBtn.AddClass("btn btn-primary btn-outline");
                                                                    //    }
                                                                    //}
                                                                }


                                                                var SecondRow = cart.FooterRow;
                                                                {

                                                                    var ProductTotalSum = SecondRow.AddColumn("Sum");
                                                                    {
                                                                        var ProductTotalSumText = ProductTotalSum.Helpers.Span();
                                                                    }

                                                                    var ProductTotalR = SecondRow.AddColumn("R");
                                                                    {
                                                                        ProductTotalR.ColSpan = 4;
                                                                        var ProductTotalRText = ProductTotalR.Helpers.Span(" : " + ViewModel.Total);
                                                                    }
                                                                }

                                                            }
                                                            var FilterBtn = FarRightColContentDiv.Helpers.Button("Check Out", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                            {
                                                                FilterBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "CheckOut($data)");
                                                                FilterBtn.AddClass("btn btn-success btn-Primary");
                                                            }
                                                            var SaveList = FarRightColContentDiv.Helpers.Button("Update Cart", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                            {
                                                                SaveList.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveCart($data)");
                                                                SaveList.AddClass("btn btn-success btn-outline");
                                                            }
                                                            var FundAccountBtns = FarRightColContentDiv.Helpers.Button("Deposit Funds ", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                            {
                                                                FundAccountBtns.AddBinding(Singular.Web.KnockoutBindingString.click, "Deposit()");
                                                                //FundAccountBtns.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveAccountList($data)");
                                                                FundAccountBtns.AddClass("btn btn-success btn-success");
                                                            }

                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }


                        }


                    }
                }
            }
        }

  %>
    <script type="text/javascript">
   
    Singular.OnPageLoad(function () {
      $("#menuItem1").addClass('active');
      $("#menuItem1 > ul").addClass('in');
    });

        var Deposit = function () {
            window.location = '../Profile/DepositFunds.aspx';
        }


//Add To Cart
        var AddToCart = function (obj) {
            ViewModel.CallServerMethod('AddToCart', { ProductID: obj.ProductID(), Price: obj.Price(), Quantity: obj.Quantity(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
               Singular.ShowMessage('Save', 'Successfully Added To Cart',900000000);
                    
                    window.location = result.Data;
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            })
        };


        /// Check Out

        var Buy = function (obj) {
            ViewModel.CallServerMethod('Buy', { ProductID: obj.ProductID(), Price: obj.Price(), Quantity: obj.Quantity(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    window.location = result.Data;
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            })
        };

    var FilterProducts = function (obj) {
      ViewModel.CallServerMethod('FilterProducts', { CategoryID: obj.CategoryID(), ResetInd: 0, ShowLoadingBar: true }, function (result) {
        if (result.Success) {
            MEHelpers.Notification("Products filtered successfully.", 'center', 'info', 1000);
            ViewModel.ProductList.Set(result.Data);
        }
        else {
          MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
        }
      })
    };

    var FilterReset = function (obj) {
        ViewModel.CallServerMethod('FilterMovies', { CategoryID: obj.CategoryID(), ResetInd: 1, ShowLoadingBar: true }, function (result) {
        if (result.Success) {
          MEHelpers.Notification("Products reset successfully.", 'center', 'info', 1000);
          ViewModel.MovieList.Set(result.Data);
          // Set Drop Down to 'Select'
        }
        else {
          MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
        }
      })
        };
        var SaveAccountList = function (obj) {
            ViewModel.CallServerMethod('SaveAccountList', { Account: ViewModel.UserAccount.Serialise(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    Singular.ShowMessage('Save', 'Account Successfully Funded');
                    window.location = result.Data;
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            })
        };


        var SaveCart = function (obj) {
            ViewModel.CallServerMethod('SaveCartList', { myBasket: ViewModel.myBasket.Serialise(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    MEHelpers.Notification("Successfully Saved", 'center', 'success', 3000);
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            });
        }
    var FilterMovieTitle = function (obj) {
      alert('test');
    };


    </script>
</asp:Content>
