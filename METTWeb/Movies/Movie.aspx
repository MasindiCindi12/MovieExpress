<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Movie.aspx.cs" Inherits="MEWeb.Movies.Movie" %>

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
                            var ContainerTab = PageTab.AddTab("Available Movies");
                            {
                                var RowContentDiv = ContainerTab.Helpers.DivC("row");
                                {
                                    #region Left Column / Data
                                    var LeftColRight = RowContentDiv.Helpers.DivC("col-md-0");
                                    {
                                    }
                                    #endregion

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
                                                var MovieContentDiv = ContentDiv.Helpers.DivC("row");
                                                {
                                                    var MovieDiv = MovieContentDiv.Helpers.DivC("col-md-12 text-center");
                                                    {
                                                        var MovieProf = MovieDiv.Helpers.TableFor<MELib.Movies.Movie>(c => c.MovieList, false, false);
                                                        {
                                                            var FirstRow = MovieProf.FirstRow;
                                                            {

                                                                var ProductName = FirstRow.AddColumn("Movie Title");
                                                                {
                                                                    var MovieTitleText = ProductName.Helpers.Span(c => c.MovieTitle);
                                                                    ProductName.Style.Width = "150px";
                                                                    //MovieTitleText.Style.TextAlign = "center";
                                                                }
                                                                var ProductImage = FirstRow.AddColumn(" ");
                                                                {
                                                                    var ProductImageText = ProductImage.Helpers.HTML("<img data-bind=\"attr:{src: $data.MovieImageURL()} \" class='movie-border'/>");
                                                                    ProductImageText.Style.Height = "70px";
                                                                    ProductImageText.Style.Width = "70px";
                                                                    ProductImage.Style.Width = "250px";
                                                                }
                                                                var ProductDescription = FirstRow.AddColumn("Movie Description");
                                                                {
                                                                    var ProductDescriptionText = ProductDescription.Helpers.Span(c => c.MovieDescription);
                                                                    ProductDescription.Style.Width = "450px";
                                                                }
                                                                var ProductPrice = FirstRow.AddColumn("Movie Price");
                                                                {
                                                                    ProductPrice.Helpers.Span("@ R");
                                                                    var ProductpriceText = ProductPrice.Helpers.Span(c => c.Price);
                                                                    ProductPrice.Style.Width = "150px";
                                                                }


                                                                var productAction = FirstRow.AddColumn("");
                                                                {
                                                                    // Buy Product
                                                                    var BuyBtn = productAction.Helpers.Button("Buy Now", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                                    {
                                                                        BuyBtn.AddBinding(Singular.Web.KnockoutBindingString.text, c => "Add To Cart");
                                                                        BuyBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "AddToCart($data)");
                                                                        BuyBtn.AddClass("btn btn-success btn-success margin-top-10");
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
                                            var ContentDiv = CardDiv.Helpers.DivC("ibox-content");
                                            {
                                                var SmallRowContentDiv = ContentDiv.Helpers.DivC("row");
                                                {
                                                    var LeftColContentDiv = SmallRowContentDiv.Helpers.DivC("col-md-12 text-left");
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
                                                            //var BalanceDiv = LeftColContentDiv.Helpers.DivC("col-md-12 text-left");
                                                            //{
                                                            //    var balance = ProfileDiv.Helpers.EditorFor(c => c.Balance);
                                                            //    balance.AddClass("form-control");
                                                            //}

                                                            ProfileDiv.Helpers.HTML("<br>");
                                                        }
                                                        var RightColContentDiv = RowContentDiv.Helpers.DivC("col-md-12 text-center");
                                                        {
                                                            // Fund Account Button

                                                            // Edit Profile
                                                            //var EditProfileBtn = LeftColContentDiv.Helpers.Button("Edit Profile", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                            //{
                                                            //    EditProfileBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "EditProfile()");
                                                            //    EditProfileBtn.AddClass("btn btn-success btn-outline");
                                                            //    EditProfileBtn.Helpers.HTML("<br>");
                                                            //    EditProfileBtn.Helpers.HTML("<br>");
                                                            //}
                                                        }


                                                        LeftColContentDiv.Helpers.HTMLTag("hr");
                                                        LeftColContentDiv.Helpers.HTML().Heading2("Cart Summary");

                                                        var cart = LeftColContentDiv.Helpers.BootstrapTableFor<MELib.Basket.Basket>((c) => c.myBasket, false, true, "");
                                                        {
                                                            var FirstRow = cart.FirstRow;
                                                            {
                                                                var ProductName = FirstRow.AddColumn("Product");
                                                                {
                                                                    var MovieTitleText = ProductName.Helpers.Span(c => c.ItemDescription);
                                                                    //ProductName.Style.Width = "150px";
                                                                }
                                                                var ProductPrice = FirstRow.AddColumn("Price");
                                                                {
                                                                    var ProductDescriptionText = ProductPrice.Helpers.Span(c => c.itemPrice);
                                                                }
                                                                var ProductDescription = FirstRow.AddColumn("Selected Quantity");
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
                                                        var FilterBtn = LeftColContentDiv.Helpers.Button("Check Out", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                        {
                                                            FilterBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "CheckOut()");
                                                            FilterBtn.AddClass("btn btn-success btn-success");
                                                        }
                                                        var SaveList = LeftColContentDiv.Helpers.Button("Update Cart", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                        {
                                                            SaveList.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveCart($data)");
                                                            SaveList.AddClass("btn btn-success btn-success");
                                                        }

                                                        var FundAccountBtns = LeftColContentDiv.Helpers.Button("Deposit Funds", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                        {
                                                            FundAccountBtns.AddBinding(Singular.Web.KnockoutBindingString.click, "Deposit()");
                                                            FundAccountBtns.AddClass("btn btn-success btn-outline");
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
    // Place page specific JavaScript here or in a JS file and include in the HeadContent section    //MovieID: obj.MovieID(), Price: obj.Price(), Movie: ViewModel.MovieList.Serialise()
    Singular.OnPageLoad(function () {
      $("#menuItem1").addClass('active');
      $("#menuItem1 > ul").addClass('in');
    });

      var Deposit = function () {
          window.location = '../Profile/DepositFunds.aspx';
      }


      //var CheckOut = function () {
      //    window.location = '../Profile/UserCheckOut.aspx';
      //}
      var AddToCart = function (obj) {
          ViewModel.CallServerMethod('AddToCart', { MovieID: obj.MovieID(), Price: obj.Price(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  window.location = result.Data;
                  Singular.ShowMessage('Save', 'Successfully Added To Cart',9000000000000000000000000000);
                 
                  location.reload();
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 9000);
              }
          })
      };

      var SaveAccountList = function (obj) {
          ViewModel.CallServerMethod('SaveAccountList', { Account: ViewModel.AccountList.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  Singular.ShowMessage('Save', 'Successfully Saved');
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
  </script>
</asp:Content>
