<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="MEWeb.Profile.Transactions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  <!-- Add page specific styles and JavaScript classes below -->
  <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
  <!-- Placeholder not used in this example -->
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
                          var ContainerTab = PageTab.AddTab("Transaction History");
                          {
                              var RowContentDiv = ContainerTab.Helpers.DivC("row");
                              {

                                  #region Left Column / Data
                                  var LeftColRight = RowContentDiv.Helpers.DivC("col-md-12");
                                  {

                                      var AnotherCardDiv = LeftColRight.Helpers.DivC("ibox float-e-margins paddingBottom");
                                      {
                                          var CardTitleDiv = AnotherCardDiv.Helpers.DivC("ibox-title");
                                          {
                                              CardTitleDiv.Helpers.HTML("<i class='ffa-lg fa-fw pull-left'></i>");
                                              CardTitleDiv.Helpers.HTML().Heading5("Transactions");
                                          }
                                          var CardTitleToolsDiv = CardTitleDiv.Helpers.DivC("ibox-tools");
                                          {
                                              var aToolsTag = CardTitleToolsDiv.Helpers.HTMLTag("a");
                                              aToolsTag.AddClass("collapse-link");
                                              {
                                                  var iToolsTag = aToolsTag.Helpers.HTMLTag("i");
                                                  iToolsTag.AddClass("fa fa-chevron-up");
                                              }



                                              var TransactionList = AnotherCardDiv.Helpers.BootstrapTableFor<MELib.Transactions.Transaction>((c) => c.TransactionList, false, false, "");
                                              {
                                                  var TransactionListRow = TransactionList.FirstRow;
                                                  {
                                                      //var TransactionTitle = TransactionListRow.AddColumn("Title");
                                                      //{
                                                      //    TransactionTitle.Style.Width = "200px";
                                                      //    var MovieTitleText = TransactionTitle.Helpers.Span(c => c.TransactionID);
                                                      //}
                                                      //var TransactionItemNo = TransactionListRow.AddColumn("Item No.").Visible=false;
                                                      //{
                                                      //    //var MovieGenreText = TransactionItemNo.Helpers.Span(c => c.TransactionTypeID).vis;
                                                      //}
                                                      var TransactionDescription = TransactionListRow.AddColumn("Item Description");
                                                      {
                                                          var TransactionDescriptionText = TransactionDescription.Helpers.Span(c => c.Description);
                                                      }
                                                      var TransactionAmount = TransactionListRow.AddColumn("Total Amount Rs");
                                                      {
                                                          var TransactionAmountText = TransactionAmount.Helpers.Span(c => c.Amount);
                                                      }

                                                      //var TransactionDates = TransactionListRow.AddColumn("Transaction Date");
                                                      //{
                                                      //    var TransactionDatesText = TransactionAmount.Helpers.Span(c => c.CreatedDate.);
                                                      //}

                                                      var Actions = TransactionListRow.AddColumn("Actions");
                                                      {
                                                          Actions.Style.Width = "150px";
                                                          // Add Buttons
                                                          var btnView = Actions.Helpers.Button("New Order", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                          {
                                                              btnView.AddClass("btn btn-success btn-outline");
                                                              btnView.AddBinding(Singular.Web.KnockoutBindingString.click, "Home()");
                                                          }

                                                      }
                                                  }
                                              }






                                          }
                                      }
                                  }
                                  #endregion


                              }
                          }

                          var REContainerTab = PageTab.AddTab("Account History");
                          {
                              var RERowContentDiv = REContainerTab.Helpers.DivC("row");
                              {

                                  #region Left Column / Data
                                  var RightColRight = RERowContentDiv.Helpers.DivC("col-md-12");
                                  {

                                      var REAnotherCardDiv = RightColRight.Helpers.DivC("ibox float-e-margins paddingBottom");
                                      {
                                          var CardTitleDiv = REAnotherCardDiv.Helpers.DivC("ibox-title");
                                          {
                                              CardTitleDiv.Helpers.HTML("<i class='ffa-lg fa-fw pull-left'></i>");
                                              CardTitleDiv.Helpers.HTML().Heading5("Transactions");
                                          }
                                          var CardTitleToolsDiv = CardTitleDiv.Helpers.DivC("ibox-tools");
                                          {
                                              var aToolsTag = CardTitleToolsDiv.Helpers.HTMLTag("a");
                                              aToolsTag.AddClass("collapse-link");
                                              {
                                                  var iToolsTag = aToolsTag.Helpers.HTMLTag("i");
                                                  iToolsTag.AddClass("fa fa-chevron-up");
                                              }



                                              var TransactionList = REAnotherCardDiv.Helpers.BootstrapTableFor<MELib.Transactions.Transaction>((c) => c.TransactionList, false, false, "");
                                              {
                                                  var TransactionListRow = TransactionList.FirstRow;
                                                  {
                                                      //var TransactionTitle = TransactionListRow.AddColumn("Title");
                                                      //{
                                                      //    TransactionTitle.Style.Width = "200px";
                                                      //    var MovieTitleText = TransactionTitle.Helpers.Span(c => c.TransactionID);
                                                      //}
                                                      //var TransactionItemNo = TransactionListRow.AddColumn("Item No.").Visible=false;
                                                      //{
                                                      //    //var MovieGenreText = TransactionItemNo.Helpers.Span(c => c.TransactionTypeID).vis;
                                                      //}
                                                      var TransactionDescription = TransactionListRow.AddColumn("Item Description");
                                                      {
                                                          var TransactionDescriptionText = TransactionDescription.Helpers.Span(c => c.Description);
                                                      }
                                                      var TransactionAmount = TransactionListRow.AddColumn("Total Amount Rs");
                                                      {
                                                          var TransactionAmountText = TransactionAmount.Helpers.Span(c => c.Amount);
                                                      }

                                                      var Actions = TransactionListRow.AddColumn("Actions");
                                                      {
                                                          Actions.Style.Width = "150px";
                                                          // Add Buttons
                                                          var btnView = Actions.Helpers.Button("Deposit", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                          {
                                                              btnView.AddClass("btn btn-success btn-outline");
                                                              btnView.AddBinding(Singular.Web.KnockoutBindingString.click, "Deposit()");
                                                          }

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

      var Home = function () {
          window.location = '../Account/Home.aspx';
      }

      var Deposit = function () {
          window.location = '../Profile/Transactions.aspx';
      }
      var AddToCart = function (obj) {
          ViewModel.CallServerMethod('AddToCart', { ProductID: obj.ProductID(), ItemDescription: obj.ItemDescription(), Price: obj.Amount(), ShowLoadingBar: true }, function (result) {
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

  </script>
</asp:Content>
