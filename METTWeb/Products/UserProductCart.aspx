<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProductCart.aspx.cs" Inherits="MEWeb.Products.UserProductCart" %>
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
                                     var RowColRight = RowContentDiv.Helpers.DivC("col-md-9");
                                     {

                                         var AnotherCardDiv = RowColRight.Helpers.DivC("ibox float-e-margins paddingBottom");
                                         {
                                             var CardTitleDiv = AnotherCardDiv.Helpers.DivC("ibox-title");
                                             {
                                                 CardTitleDiv.Helpers.HTML("<i class='ffa-lg fa-fw pull-left'></i>");
                                                 CardTitleDiv.Helpers.HTML().Heading5("Select - Purchase For User");
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
                                             var ContentDiv = AnotherCardDiv.Helpers.DivC("ibox-content");
                                             {
                                                 var RightRowContentDiv = ContentDiv.Helpers.DivC("row");
                                                 {


                                                     var ColContentDiv = RightRowContentDiv.Helpers.DivC("col-md-12");
                                                     {
                                                         var ProductsDiv = ColContentDiv.Helpers.BootstrapTableFor<MELib.Products.Product>((c) => c.ProductList, false, false, "");
                                                         {
                                                             var FirstRow = ProductsDiv.FirstRow;
                                                             {
                                                                 var ProductName = FirstRow.AddColumn("Product Name");
                                                                 {
                                                                     var MovieTitleText = ProductName.Helpers.Span(c => c.ProductName);
                                                                     ProductName.Style.Width = "250px";
                                                                 }
                                                                 var ProductDescription = FirstRow.AddColumn("Description");
                                                                 {
                                                                     var ProductDescriptionText = ProductDescription.Helpers.Span(c => c.ProductDescription);
                                                                 }
                                                                 var ProductImage = FirstRow.AddColumn("Product Image2");
                                                                 {
                                                                     ProductImage.Helpers.HTML("<img data-bind=\"attr:{src: $data.ProductImageURL()} \" class='movie-border'  width='100px' height='100px' />");

                                                                     //var ProductImageText = ProductImage.Helpers.Span(c => c.ProductImageURL);
                                                                 }
                                                                 var ProductPrice = FirstRow.AddColumn("Price Rs");
                                                                 {
                                                                     ProductPrice.Helpers.HTML("R ");
                                                                     var ProductPriceText = ProductPrice.Helpers.Span(c => c.Price);
                                                                 }

                                                                 var ProductQty = FirstRow.AddColumn("Quantity");
                                                                 {

                                                                     var ProductPriceText = ProductQty.Helpers.EditorFor(c => c.Quantity);
                                                                     //var ProductPriceText1 = ProductQty.Helpers.TextBoxFor(c => c.Price);
                                                                 }

                                                                 var productAction = FirstRow.AddColumn("");
                                                                 {


                                                                     // Buy Product
                                                                     var BuyBtn = productAction.Helpers.Button("Buy Now", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                                     {
                                                                         BuyBtn.AddBinding(Singular.Web.KnockoutBindingString.text, c => "Add To Cart");
                                                                         BuyBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "AddToCart($data)");
                                                                         BuyBtn.AddClass("btn btn-success btn-success ");
                                                                     }
                                                                 }
                                                             }
                                                         }
                                                     }




                                                 }
                                             }
                                         }



                                     }
                                     var RowColRightt = RowContentDiv.Helpers.DivC("col-md-3");
                                     {

                                         var AnotherCardDiv = RowColRightt.Helpers.DivC("ibox float-e-margins paddingBottom");
                                         {
                                             var CardTitleDiv = AnotherCardDiv.Helpers.DivC("ibox-title");
                                             {
                                                 CardTitleDiv.Helpers.HTML("<i class='fa fa-shopping-cart pull-left'></i>");
                                                 CardTitleDiv.Helpers.HTML().Heading5("Cart");
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
                                                             var UserDiv = FarLeftColContentDiv.Helpers.With<MELib.Accounts.Account>(c => c.UserAccount);
                                                             {
                                                                 UserDiv.Helpers.Span("Available Balance : R").Style.FontSize = "20px";
                                                                 UserDiv.Helpers.EditorFor(c => c.Balance);
                                                                 UserDiv.AddClass("form-control");
                                                             }
                                                             UserDiv.Helpers.HTML("<br>");
                                                             UserDiv.Helpers.HTML("<br>");
                                                             UserDiv.Helpers.HTML("<br>");

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


                                                         var cart = RightColContentDiv.Helpers.BootstrapTableFor<MELib.Basket.Basket>((c) => c.myBasket, false, true, "");
                                                         {
                                                             var FirstRow = cart.FirstRow;
                                                             {
                                                                 var UserName = FirstRow.AddColumn("User");
                                                                 {
                                                                     var UserText = UserName.Helpers.Span(c => c.UserID);
                                                                     UserText.Style.Width = "50px";
                                                                 }
                                                                 var ProductName = FirstRow.AddColumn("Product");
                                                                 {
                                                                     var MovieTitleText = ProductName.Helpers.Span(c => c.ItemDescription);
                                                                     ProductName.Style.Width = "250px";
                                                                 }

                                                                 var ProductPrice = FirstRow.AddColumn("Price");
                                                                 {
                                                                     var ProductDescriptionText = ProductPrice.Helpers.Span(c => c.itemPrice);
                                                                 }
                                                                 var ProductDescription = FirstRow.AddColumn("Quantity");
                                                                 {
                                                                     var ProductDescriptionText = ProductDescription.Helpers.EditorFor(c => c.itemQty);
                                                                     ProductDescriptionText.Style.Width = "50px";
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
                                                             FilterBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "checkout()");
                                                             FilterBtn.AddClass("btn btn-success btn-success");
                                                         }

                                                        var SaveList = RightColContentDiv.Helpers.Button("Update Cart", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                       {
                                                           SaveList.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveCart($data)");
                                                           SaveList.AddClass("btn btn-success btn-success");
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

        var checkout = function () {
            window.location = '../Profile/UserCheckOut.aspx';
        }

        var AddToCart = function (obj) {
            ViewModel.CallServerMethod('AddToCart', { ProductID: obj.ProductID(), Price: obj.Price(), Qty: obj.Quantity(), UserId: ViewModel.UserId(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    MEHelpers.Notification("Products successfully Added to Cart.", 'center', 'info', 1000);
                    window.location = result.Data;
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            })
        };

        var UserInfo = function (obj) {
            ViewModel.CallServerMethod('UserInfo', { UserId: ViewModel.UserId(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    MEHelpers.Notification("User Info Refreshed.", 'center', 'info', 1000);
                    ViewModel.myBasket.Set(result.Data);
                    // ViewModel.ProductList.Set(result.Data);
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
    </script>
</asp:Content>
