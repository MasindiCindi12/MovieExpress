<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="MEWeb.Products.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
      <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
     <style type="text/css">
    .movie-border {
      border-radius: 5px;
   
      padding: 15px;
      margin: 5px;
      width:250px;
      height:250px;
    }


         </style>
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

                                      #region Deposit Column / Filters
                                      var MiddleColRight = RowContentDiv.Helpers.DivC("col-md-8");
                                      {

                                          var AnotherCardDiv = MiddleColRight.Helpers.DivC("ibox float-e-margins paddingBottom");
                                          {
                                              var CardTitleDiv = AnotherCardDiv.Helpers.DivC("ibox-title");
                                              {
                                                  CardTitleDiv.Helpers.HTML("<i class='ffa-lg fa-fw pull-left'></i>");
                                                  CardTitleDiv.Helpers.HTML().Heading5("Transaction Purchase Confirmation");
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
                                                  var ProductContentDiv = ContentDiv.Helpers.DivC("row");
                                                  {
                                                      var productDiv = ProductContentDiv.Helpers.DivC("col-md-12 text-left");
                                                      {
                                                          var ProductList = productDiv.Helpers.TableFor<MELib.Products.Product>(c => c.ProductListing, false, false);
                                                          {
                                                              var FirstRow = ProductList.FirstRow;
                                                              {

                                                                  var ProductName = FirstRow.AddColumn("Product Title");
                                                                  {
                                                                      var ProductNameText = ProductName.Helpers.Span(c => c.ProductName);
                                                                      ProductNameText.Style.Width = "300px";
                                                                      ProductName.Style.Width = "350px";
                                                                      //MovieTitleText.Style.TextAlign = "center";
                                                                  }
                                                                  var ProductImage = FirstRow.AddColumn(" ");
                                                                  {
                                                                      var ProductImageText = ProductImage.Helpers.HTML("<img data-bind=\"attr:{src: $data.ProductImageURL()} \" class='movie-border'/>");
                                                                       ProductImage.Style.Width = "50px";
                                                                      ProductImageText.Style.Width = "50px";
                                                                  }
                                                                  var ProductDescription = FirstRow.AddColumn("Product Description");
                                                                  {
                                                                      var ProductDescriptionText = ProductDescription.Helpers.Span(c => c.ProductDescription);

                                                                      ProductDescriptionText.Style.Width = "1290px";
                                                                      ProductDescription.Style.Width = "1500px";
                                                                  }
                                                                  var ProductPrice = FirstRow.AddColumn("Product Price");
                                                                  {
                                                                      ProductPrice.Helpers.Span("@ R");
                                                                      var ProductpriceText = ProductPrice.Helpers.Span(c => c.Price);
                                                                      ProductpriceText.Style.Width = "550px";
                                                                      ProductPrice.Style.Width = "550px";
                                                                      ProductPrice.AddClass("text-center");
                                                                  }
                                                                  var ProductQuantity = FirstRow.AddColumn("Product Quantity");
                                                                  {
                                                                      // ProductPrice.Helpers.Span("@ R");
                                                                      var ProductQuantityText = ProductQuantity.Helpers.EditorFor(c => c.Quantity);
                                                                      ProductQuantityText.Style.Width = "40px";
                                                                      ProductQuantity.Style.Width = "70px";
                                                                  }


                                                                  var productAction = FirstRow.AddColumn("");
                                                                  {
                                                                      // Buy Product
                                                                      var BuyBtn = productAction.Helpers.Button("Buy Now", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.shoppingCart);
                                                                      {
                                                                          BuyBtn.AddBinding(Singular.Web.KnockoutBindingString.text, c => "Add To Cart");
                                                                          BuyBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "AddToCart($data)");
                                                                          BuyBtn.AddClass("btn btn-success btn-primary");


                                                                      }

                                                                      productAction.Style.Width = "200px";
                                                                  }

                                                                  var PageAction = FirstRow.AddColumn("");
                                                                  {
                                                                      // Buy Product
                                                                      var BackBtn = PageAction.Helpers.Button("Back", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.arrow_circle_left);
                                                                      {
                                                                          BackBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "GoBack()");
                                                                          BackBtn.AddClass("btn btn-success btn-outline margin-top-10");
                                                                      }
                                                                  }
                                                              }

                                                          }

                                                      }
                                                  }

                                              }
                                          }
                                      }


                                      #endregion
                                      #region Right Column / Data
                                      var RowColRight = RowContentDiv.Helpers.DivC("col-md-4");
                                      {

                                          var CardDiv = RowColRight.Helpers.DivC("ibox float-e-margins paddingBottom");
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

                                              var CartContentDiv = CardDiv.Helpers.DivC("ibox-content");
                                              {

                                                  var AnotherRowContentDiv = CartContentDiv.Helpers.DivC("row");
                                                  {
                                                      var LeftColContentDiv = AnotherRowContentDiv.Helpers.DivC("col-md-12 text-left");
                                                      {

                                                          var UserDiv = LeftColContentDiv.Helpers.With< MELib.Security.UserList>(c => c.UserDetails);
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
                                                              //ProfileDiv.Helpers.HTML("Amount");
                                                              //var BalanceDiv = RowContentDiv.Helpers.DivC("col-md-12 text-center");
                                                              //{
                                                              //    var balance = ProfileDiv.Helpers.EditorFor(c => c.Balance);
                                                              //    balance.AddClass("form-control");
                                                              //}

                                                              //ProfileDiv.Helpers.HTML("<br>");

                                                          }



                                                          //var RightColContentDiv = RowContentDiv.Helpers.DivC("col-md-12 text-center");
                                                          //{
                                                          //    // Fund Account Button
                                                          //    var FundAccountBtns = LeftColContentDiv.Helpers.Button("Deposit Funds", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                          //    {
                                                          //        FundAccountBtns.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveAccountList()");
                                                          //        FundAccountBtns.AddClass("btn btn-success btn-primary");
                                                          //    }
                                                          //    // Edit Profile
                                                          //    var EditProfileBtn = LeftColContentDiv.Helpers.Button("Edit Profile", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                          //    {
                                                          //        EditProfileBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "EditProfile()");
                                                          //        EditProfileBtn.AddClass("btn btn-success btn-outline");
                                                          //        EditProfileBtn.Helpers.HTML("<br>");
                                                          //        EditProfileBtn.Helpers.HTMLTag("<hr>");
                                                          //    }
                                                          //}
                                                      }
                                                  }

                                                  //Add a delivery Drop down here

                                                  var CartRowContentDiv = CartContentDiv.Helpers.DivC("row");
                                                  {
                                                      var LeftColContentDiv = CartRowContentDiv.Helpers.DivC("col-md-12 text-left");
                                                      {
                                                          LeftColContentDiv.Helpers.HTMLTag("hr/");
                                                          LeftColContentDiv.Helpers.HTML().Heading2("Cart Summary");
                                                          LeftColContentDiv.Helpers.HTMLTag("br/");

                                                          // var FarRightColContentDiv = LeftColContentDiv.Helpers.DivC("col-md-12");
                                                          //{
                                                          //    LeftColContentDiv.Helpers.LabelFor(c => ViewModel.ShipmentMethodID);
                                                          //    var ReleaseFromDateEditor = LeftColContentDiv.Helpers.EditorFor(c => ViewModel.ShipmentMethodID);
                                                          //    ReleaseFromDateEditor.AddClass("form-control marginBottom20 ");


                                                          //}
                                                          //LeftColContentDiv.Helpers.HTMLTag("br/");


                                                          var cart = LeftColContentDiv.Helpers.BootstrapTableFor<MELib.Basket.Basket>((c) => c.myBasket, false, true, "");
                                                          {
                                                              var FirstRow = cart.FirstRow;
                                                              {
                                                                  var ProductName = FirstRow.AddColumn("Product");
                                                                  {
                                                                      var ProductNameText = ProductName.Helpers.Span(c => c.ItemDescription);
                                                                      // ProductName.Style.Width = "0px";
                                                                  }
                                                                  var ProductPrice = FirstRow.AddColumn("Price");
                                                                  {
                                                                      var ProductPriceText = ProductPrice.Helpers.Span(c => c.itemPrice);
                                                                  }
                                                                  var ProductQuantity = FirstRow.AddColumn("Quantity");
                                                                  {
                                                                      var ProductQuantityText = ProductQuantity.Helpers.EditorFor(c => c.itemQty);
                                                                      ProductQuantityText.Style.Width = "30px";
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


                                                          var FilterBtn = LeftColContentDiv.Helpers.Button("Check Out", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                          {
                                                              FilterBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "CheckOut()");
                                                              FilterBtn.AddClass("btn btn-success btn-primary");
                                                          }
                                                          var SaveList = LeftColContentDiv.Helpers.Button("Update Cart", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                          {
                                                              SaveList.AddBinding(Singular.Web.KnockoutBindingString.click, "UpdateCart($data)");
                                                              SaveList.AddClass("btn btn-success btn-primary");
                                                          }


                                                      }
                                                  }
                                              }





                                          }
                                      }
                                      #endregion


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


      var GoBack = function () {
          window.location = '../Products/AllProducts.aspx';
      }

      var CheckOut = function () {
          window.location = '..//Profile/CheckOutBasket.aspx';
      }

      var EditProfile = function () {
          window.location = '../Profile/BasicUser.aspx';
      }


      var AddToCart = function (obj) {
          ViewModel.CallServerMethod('AddToCart', { ProductID: obj.ProductID(), Price: obj.Price(), Qty: obj.Quantity(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  window.location = result.Data;
                  Singular.ShowMessage('Save', 'Product Added To Cart',900000000000000000);
                  location.reload();
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



      var UpdateCart = function (obj) {
          ViewModel.CallServerMethod('UpdateCart', { myBasket: ViewModel.myBasket.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  Singular.ShowMessage('Save', 'Cart Successfully Update');
                  MEHelpers.Notification("Cart Successfully Updated", 'center', 'success', 3000);
                  location.reload();
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          });
      }
  </script>


</asp:Content>
