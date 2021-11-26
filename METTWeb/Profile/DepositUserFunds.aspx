<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DepositUserFunds.aspx.cs" Inherits="MEWeb.Profile.DepositUserFunds" %>
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

                                                        RightColContentDiv.Helpers.HTMLTag("br/");
                                                        var cart = RightColContentDiv.Helpers.BootstrapTableFor<MELib.Accounts.Account>((c) => c.UserAccount, false, false, "");
                                                        {
                                                            var FirstRow = cart.FirstRow;
                                                            {
                                                                var UserName = FirstRow.AddColumn("");
                                                                {
                                                                    var UserText = UserName.Helpers.Span(c => c.UserID);
                                                                    UserName.HeaderText = "User";
                                                                }
                                                                var UserBalance = FirstRow.AddColumn("");
                                                                {
                                                                    var UserBalanceText = UserBalance.Helpers.EditorFor(c => c.Balance);
                                                                    UserBalance.HeaderText = "Balance";
                                                                }

                                                            }
                                                        }

                                                    }

                                                    var ClearBtn = RightColContentDiv.Helpers.Button("Deposit Funds", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                    {
                                                        ClearBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveAccount($data)");
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

        var UserInfo = function (obj) {
            console.log(obj.UserAccount)
            ViewModel.CallServerMethod('UserInfo', { UserId: ViewModel.UserId(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    MEHelpers.Notification("User Info Refreshed.", 'center', 'info', 1000);
                    ViewModel.UserAccount.Set(result.Data);

                    console.log(result.Data);
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            })
        };
        var SaveAccount = function (obj) {
            ViewModel.CallServerMethod('SaveAccountList', { UserId: ViewModel.UserId(), UserAccount: obj.UserAccount.Serialise(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    MEHelpers.Notification("User Account Funded Successfully.", 'center', 'info', 1000);
                    window.location = result.Data;
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                }
            })
        };

        //function (data) {
        //    console.log(obj.UserAccount);
        //    ViewModel.CallServerMethod('', { UserId: ViewModel.UserId(), UserAccount: obj.UserAccount.Serialise(), Account: ViewModel.AccountList.Serialise(), ShowLoadingBar: true }, function (result) {
        //        if (result.Success) {
        //            Singular.ShowMessage('Save', 'Successfully Saved');
        //            location.reload();
        //        }
        //        else {
        //            Singular.AddMessage(1, 'Error', result.ErrorText).Fade(2000);
        //            location.reload();
        //        }
        //    });
        //}
    </script>

</asp:Content>
