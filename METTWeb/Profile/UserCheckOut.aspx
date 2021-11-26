<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserCheckOut.aspx.cs" Inherits="MEWeb.Profile.UserCheckOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
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
                            {
                                var RowContentDiv = ContainerTab.Helpers.DivC("row");
                                {

                                    var RowColRightt = RowContentDiv.Helpers.DivC("col-md-12");
                                    {

                                        var AnotherCardDiv = RowColRightt.Helpers.DivC("ibox float-e-margins paddingBottom");
                                        {
                                            var CardTitleDiv = AnotherCardDiv.Helpers.DivC("ibox-title");
                                            {


                                                CardTitleDiv.Helpers.HTML("&nbsp;");
                                                CardTitleDiv.Helpers.HTML("<i class='fa fa-shopping-cart pull-left'></i>");
                                                CardTitleDiv.Helpers.HTML().Heading5("Cart");
                                                CardTitleDiv.Helpers.HTML("&nbsp;");
                                                var RealoadBtn = CardTitleDiv.Helpers.Button("", Singular.Web.ButtonMainStyle.Default, Singular.Web.ButtonSize.Tiny, Singular.Web.FontAwesomeIcon.circleOutline);
                                                {
                                                    RealoadBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "Reload()");
                                                    RealoadBtn.AddClass("btn btn-success btn-outline");
                                                }


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

                                            var ContentDiv = CardTitleDiv.Helpers.DivC("ibox-content");
                                            {
                                                var RightColRowContentDiv = ContentDiv.Helpers.DivC("row");
                                                {

                                                    var LeftColContentDiv = RightColRowContentDiv.Helpers.DivC("col-md-12 text-left");
                                                    {

                                                        var FarLeftColContentDiv = LeftColContentDiv.Helpers.DivC("col-md-12 text-left");
                                                        {
                                                            //var UserDiv = FarLeftColContentDiv.Helpers.With<MELib.Accounts.Account>(c => c.UserAccount);
                                                            //{
                                                            //    UserDiv.Helpers.Span("Available Balance : R").Style.FontSize = "20px";
                                                            //    UserDiv.Helpers.EditorFor(c => c.Balance);
                                                            //    UserDiv.AddClass("form-control");
                                                            //}
                                                            //UserDiv.Helpers.HTML("<br>");
                                                            //UserDiv.Helpers.HTML("<br>");
                                                            //UserDiv.Helpers.HTML("<br>");

                                                        }

                                                        var ProfileDiv = LeftColContentDiv.Helpers.With<MELib.RO.ROUser>(c => c.users);
                                                        {
                                                            ProfileDiv.Helpers.HTML().Heading2("Search Customers");

                                                        }

                                                        var RightColContentDiv = RightColRowContentDiv.Helpers.DivC("col-md-12");
                                                        {
                                                            RightColContentDiv.Helpers.LabelFor(c => ViewModel.UserId);
                                                            var ReleaseFromDateEditor = RightColContentDiv.Helpers.EditorFor(c => c.UserId);
                                                            ReleaseFromDateEditor.AddClass("form-control");
                                                            RightColContentDiv.Helpers.HTMLTag("br/");

                                                            var FilterBtn = RightColContentDiv.Helpers.Button("Get User", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                            {
                                                                FilterBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "UserInfo($data)");
                                                                FilterBtn.AddClass("btn btn-success btn-success");

                                                            }

                                                            RightColContentDiv.Helpers.HTMLTag("br/");
                                                        }

                                                    }

                                                }
                                            }
                                            var ContentDiv1 = AnotherCardDiv.Helpers.DivC("ibox-content");
                                            {
                                                var RightRowContentDiv = ContentDiv1.Helpers.DivC("row");
                                                {
                                                    var RightColContentDiv = RightRowContentDiv.Helpers.DivC("col-md-12");
                                                    {
                                                        RightColContentDiv.Helpers.HTML().Heading2("Cart Summary");
                                                        RightColContentDiv.Helpers.HTMLTag("br/");

                                                        var FarRightColContentDiv = RightRowContentDiv.Helpers.DivC("col-md-12");
                                                        {
                                                            RightColContentDiv.Helpers.LabelFor(c => ViewModel.ShipmentMethodID);
                                                            var ReleaseFromDateEditor = RightColContentDiv.Helpers.EditorFor(c => ViewModel.ShipmentMethodID);
                                                            ReleaseFromDateEditor.AddClass("form-control marginBottom20 ");

                                                        }
                                                        RightColContentDiv.Helpers.HTMLTag("br/");
                                                        RightColContentDiv.Helpers.HTML().Heading4("Shipment Costs");
                                                        RightColContentDiv.Helpers.HTML("Delivery R60.");

                                                        RightColContentDiv.Helpers.HTML("Collection R0 (Free).");
                                                        RightColContentDiv.Helpers.HTMLTag("br/");
                                                        var cart = RightColContentDiv.Helpers.BootstrapTableFor<MELib.Basket.Basket>((c) => c.myBasket, false, true, "");
                                                        {
                                                            var FirstRow = cart.FirstRow;
                                                            {
                                                                var UserName = FirstRow.AddColumn("User");
                                                                {
                                                                    var UserText = UserName.Helpers.EditorFor(c => c.UserID);
                                                                    UserText.Style.Width = "50px";
                                                                }
                                                                var ProductName = FirstRow.AddColumn("Product");
                                                                {
                                                                    var MovieTitleText = ProductName.Helpers.Span(c => c.ItemDescription);
                                                                    ProductName.Style.Width = "250px";
                                                                }

                                                                var ProductPrice = FirstRow.AddColumn("Price Rs");
                                                                {
                                                                    var ProductDescriptionText = ProductPrice.Helpers.Span(c => c.itemPrice);
                                                                }
                                                                var ProductDescription = FirstRow.AddColumn("Quantity");
                                                                {
                                                                    var ProductDescriptionText = ProductDescription.Helpers.EditorFor(c => c.itemQty);
                                                                }

                                                                var ProductTotal = FirstRow.AddColumn("Total");
                                                                {
                                                                    var ProductTotalText = ProductTotal.Helpers.Span(c => c.TotalPrice);
                                                                }
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
                                                        var FilterBtn = RightColContentDiv.Helpers.Button("Check Out", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                        {
                                                            FilterBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "CheckOut($data)");
                                                            FilterBtn.AddClass("btn btn-success btn-success");
                                                        }

                                                        var UpdateBtn = RightColContentDiv.Helpers.Button("Update Cart", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                        {
                                                            UpdateBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveCart($data)");
                                                            UpdateBtn.AddClass("btn btn-success btn-success");
                                                        }
                                                        var ClearBtn = RightColContentDiv.Helpers.Button("Deposit Funds", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                        {
                                                            ClearBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "DepositFunds()");
                                                            ClearBtn.AddClass("btn btn-success btn-outline");
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
        // Place page specific JavaScript here or in a JS file and include in the HeadContent section
        Singular.OnPageLoad(function () {
            $("#menuItem1").addClass('active');
            $("#menuItem1 > ul").addClass('in');
        });

        var DepositFunds = function () {
            window.location = '../Profile/DepositUserFunds.aspx';
        }
        var Reload = function () {
            location.reload();
        }
        
        var CheckOut = function (obj) {
            ViewModel.CallServerMethod('CheckOut', { UserId: ViewModel.UserId(), ShipmentMethodID: ViewModel.ShipmentMethodID(), uncheckedBasket: obj.myBasket.Serialise(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    MEHelpers.Notification("Products successfully Checked Out.", 'center', 'info', 1000);
                    window.location = result.Data;
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            })
        };
        var SaveCart = function (obj) {
            ViewModel.CallServerMethod('SaveCartList', { UserId: ViewModel.UserId(),myBasket: ViewModel.myBasket.Serialise(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    MEHelpers.Notification("Successfully Saved", 'center', 'success', 3000);
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            });
        }
        var UserInfo = function (obj) {
            console.log(obj.UserAccount)
            ViewModel.CallServerMethod('UserInfo', { UserId: ViewModel.UserId(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    MEHelpers.Notification("User Info Refreshed.", 'center', 'info', 1000);
                    ViewModel.myBasket.Set(result.Data);
                 
                    console.log(result.Data);
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            })
        };
    </script>


</asp:Content>
