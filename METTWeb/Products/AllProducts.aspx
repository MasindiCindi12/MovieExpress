<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllProducts.aspx.cs" Inherits="MEWeb.Products.AllProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

      <!-- Add your page specific styles and JavaScript classes below -->
  <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
  <style type="text/css">
    .movie-border {
      border-radius: 5px;
      border: 2px solid #DEDEDE;
      padding: 15px;
      margin: 5px;
      width:200px;
      height:200px;
    }

    div.movie-item {
      vertical-align: top;
      display: inline-block;
      text-align: center;
    }

    .caption {
      display: block;
    }

    .margin-top-10 {
      margin-top: 10px;
    }
    /* Pagination*/
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <%
         using (var h = this.Helpers)
         {
             var MainHDiv = h.DivC("row pad-top-10");
             {
                 var PanelContainer = MainHDiv.Helpers.DivC("col-md-12 p-n-lr");
                 {
                     var HomeContainer = PanelContainer.Helpers.DivC("tabs-container");
                     {
                         var AssessmentsTab = HomeContainer.Helpers.TabControl();
                         {
                             AssessmentsTab.Style.ClearBoth();
                             AssessmentsTab.AddClass("nav nav-tabs");
                            
                             var HomeContainerTab1 = AssessmentsTab.AddTab("Products");
                             {
                                 var Row = HomeContainerTab1.Helpers.DivC("row margin0");
                                 {
                                     var RowColMain = Row.Helpers.DivC("col-md-12");
                                     {
                                         RowColMain.Helpers.HTML().Heading2("Welcome Back to Snack Express");
                                         RowColMain.Helpers.HTMLTag("p").HTML = "On your dashboard below you will see the available products.";
                                     }
                                     var RowColLeft = Row.Helpers.DivC("col-md-8");
                                     {
                                         var AnotherCardDiv = RowColLeft.Helpers.DivC("ibox float-e-margins paddingBottom");
                                         {
                                             var CardTitleDiv = AnotherCardDiv.Helpers.DivC("ibox-title");
                                             {
                                                 CardTitleDiv.Helpers.HTML("<i class='ffa-lg fa-fw pull-left'></i>");
                                                 CardTitleDiv.Helpers.HTML().Heading5("Edible Products");
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
                                                 var RowContentDiv = ContentDiv.Helpers.DivC("row");
                                                 {

                                                     
                                                     var MovieColContentDiv = RowContentDiv.Helpers.DivC("col-md-12");
                                                     {
                                                       
                                                         var MovieColContainer = MovieColContentDiv.Helpers.DivC("movies-container");
                                                         {
                                                             var MoviesWatchedDiv = MovieColContainer.Helpers.ForEach<MELib.Products.Product>(c => c.ProductList);
                                                             {

                                                                 MoviesWatchedDiv.Helpers.HTML("<div class='movie-item'>");
                                                                 MoviesWatchedDiv.Helpers.HTML("<img data-bind=\"attr:{src: $data.ProductImageURL()} \" class='movie-border'/>");
                                                                 MoviesWatchedDiv.Helpers.HTML("<b><span data-bind=\"text: $data.ProductName() \"  class='caption'></span></b>");

                                                             }
                                                             var WatchBtn = MoviesWatchedDiv.Helpers.Button("View Now", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                             {
                                                                 WatchBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "ViewProduct($data)");
                                                                 WatchBtn.AddClass("btn btn-success btn-outline margin-top-10");
                                                             }
                                                             MoviesWatchedDiv.Helpers.HTML("</div>");
                                                         }
                                                         var MoviPaginationColContainer = MovieColContentDiv.Helpers.DivC("pagination-container");
                                                         {
                                                         }
                                                     }
                                                 }

                                             }
                                         }
                                     }
                                     var RowCol = Row.Helpers.DivC("col-md-4");
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
                                                 var RowContentDiv = ContentDiv.Helpers.DivC("row");
                                                 {
                                                     var LeftColContentDiv = RowContentDiv.Helpers.DivC("col-md-12 text-left");
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
                                                             ProfileDiv.Helpers.HTML("Amount");
                                                             var BalanceDiv = RowContentDiv.Helpers.DivC("col-md-12 text-center");
                                                             {
                                                                 var balance = ProfileDiv.Helpers.EditorFor(c => c.Balance);
                                                                 balance.AddClass("form-control");
                                                             }

                                                             ProfileDiv.Helpers.HTML("<br>");

                                                         }
                                                         var RightColContentDiv = RowContentDiv.Helpers.DivC("col-md-12 text-center");
                                                         {
                                                             // Fund Account Button   ---- Here
                                                             var FundAccountBtns = RightColContentDiv.Helpers.Button("Deposit Funds ", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                             {
                                                                 FundAccountBtns.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveAccountList($data)");
                                                                 //FundAccountBtns.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveAccountList($data)");
                                                                 FundAccountBtns.AddClass("btn btn-success btn-success");
                                                             }
                                                             // Edit Profile
                                                             var EditProfileBtn = RightColContentDiv.Helpers.Button("Edit Profile", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                             {
                                                                 EditProfileBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "EditProfile()");
                                                                 EditProfileBtn.AddClass("btn btn-success btn-outline");
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
  <!-- Place your JavaScript in a file e.g. '../Scripts/home.js' and include it in the header section of each page  -->
  <script type="text/javascript">
      // On page load
      Singular.OnPageLoad(function () {
          $("#menuItem0").addClass("active");
      });


      var ViewProduct = function (obj) {
          ViewModel.CallServerMethod('ViewProduct', { ProductID: obj.ProductID(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  window.location = result.Data;
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          })
      }
      //
      var RentMovie = function (obj) {
          ViewModel.CallServerMethod('RentMovie', { MovieID: obj.MovieID(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  window.location = result.Data;
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          })
      }

      var EditProfile = function () {
          window.location = '../Profile/BasicUser.aspx';
      }

     
      var SaveAccountList = function (obj) {
          ViewModel.CallServerMethod('SaveAccountList', { Account: ViewModel.UserAccount.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  Singular.ShowMessage('Save', 'Account Successfully Funded');
                  window.location = result.Data;
                  location.reload();
              }
              else {
                  //   location.reload();
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);

              }

          });
          
      }
      var CheckOut = function (obj) {
          console.log(obj.myBasket())
          console.log(ViewModel.ShipmentMethodID())
          ViewModel.CallServerMethod('CheckOut', { shipmentMethodID: ViewModel.ShipmentMethodID(), uncheckedBasket: obj.myBasket.Serialise(), ShowLoadingBar: true }, function (result) {
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


      var AddToCart = function (obj) {
          ViewModel.CallServerMethod('AddToCart', { ProductID: obj.ProductID(), Price: obj.Price(), Qty: obj.Quantity(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  Singular.ShowMessage('Save', 'Items Added To Cart');
                  window.location = result.Data;
                  location.reload();
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          })
      };


      var SaveCartList = function (obj) {
          ViewModel.CallServerMethod('SaveCartList', { myBasket: ViewModel.myBasket.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  Singular.ShowMessage('Save', 'Cart Successfully Updated');
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
