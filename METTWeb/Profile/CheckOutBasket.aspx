<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckOutBasket.aspx.cs" Inherits="MEWeb.Profile.CheckOutBasket" %>
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
                                                  CardTitleDiv.Helpers.HTML("<i class='fa fa-shopping-cart pull-left'></i>");
                                                  CardTitleDiv.Helpers.HTML().Heading5("Check Out Cart");
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
                                                      var LeftColContentDiv = RightColRowContentDiv.Helpers.DivC("col-md-10 text-center");
                                                      {

                                                          var UserDiv = LeftColContentDiv.Helpers.With< MELib.Security.UserList>(c => c.UserDetails);
                                                          {
                                                              UserDiv.Helpers.Span(c => c.FirstOrDefault().FirstName).Style.FontSize = "17px";
                                                              UserDiv.Helpers.Span(c => c.FirstOrDefault().Surname).Style.FontSize = "17px";
                                                          }

                                                          var ProfileDiv = LeftColContentDiv.Helpers.With<MELib.Accounts.Account>(c => c.UserAccount);
                                                          {
                                                              ProfileDiv.Helpers.HTMLTag("br/");
                                                              ProfileDiv.Helpers.Span("Available Balance :  R").Style.FontSize = "20px";
                                                              ProfileDiv.Helpers.Span(c => c.Balance).Style.FontSize = "20px";



                                                              ProfileDiv.Helpers.HTML("<br>");
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
                                                                      // ProductTotal.Helpers.LabelFor(c => ViewModel.Total);
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
                                                              FilterBtn.AddClass("btn btn-success btn-primary");
                                                          }
                                                          var SaveList = RightColContentDiv.Helpers.Button("Update Cart", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                          {
                                                              SaveList.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveCart($data)");
                                                              SaveList.AddClass("btn btn-success btn-primary");
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

        var EditProfile = function () {
            window.location = '../Profile/BasicUser.aspx';
        }

        var CheckOut = function (obj) {
            console.log(obj.myBasket())
            console.log(ViewModel)
            ViewModel.CallServerMethod('CheckOut', { Total: ViewModel.Total, shipmentMethodID: ViewModel.ShipmentMethodID(), uncheckedBasket: obj.myBasket.Serialise(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    window.location = result.Data;
                   /* Singular.mess("Products successfully Checked Out.", 'center', 'info', 5000);*/
                    Singular.ShowMessage('Save', 'Successfully Saved', 900000000);
                   
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 10000);
                }
            })
        };

  

 

    </script>
</asp:Content>
