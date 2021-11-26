<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DepositFunds.aspx.cs" Inherits="MEWeb.Profile.DepositFunds" %>

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
                            var ContainerTab = PageTab.AddTab("Account Balance");
                            {
                                var RowContentDiv = ContainerTab.Helpers.DivC("row");
                                {

                                    #region Left Column / Data
                                    var LeftColRight = RowContentDiv.Helpers.DivC("col-md-2");
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
                                                CardTitleDiv.Helpers.HTML().Heading5("Deposit Funds");
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

                                            var CardContentDiv = AnotherCardDiv.Helpers.DivC("ibox-content");
                                            {
                                                var MainColRight = CardContentDiv.Helpers.DivC("row");
                                                {
                                                    var ColNoContentDiv = MainColRight.Helpers.DivC("col-md-12 text-left");
                                                    {

                                                        var UserDiv = ColNoContentDiv.Helpers.With<MELib.Security.UserList>(c => c.UserDetails);
                                                        {
                                                            UserDiv.Helpers.Span("Username:  ").Style.FontSize = "17px";
                                                            UserDiv.Helpers.Span(c => c.FirstOrDefault().LoginName).Style.FontSize = "17px";
                                                            UserDiv.Helpers.HTMLTag("br/");
                                                        }

                                                        var UserAccount = ColNoContentDiv.Helpers.With<MELib.Accounts.Account>(c => c.AccountList);
                                                        {
                                                            var AccountID = ColNoContentDiv.Helpers.DivC("col-md-12");
                                                            {

                                                                UserAccount.Helpers.Span("Available Balance : R ").Style.FontSize = "15px";
                                                                UserAccount.Helpers.Span(c => c.Balance).Style.FontSize = "15px";
                                                                UserAccount.Helpers.HTMLTag("br/ ");
                                                                //UserAccount.Helpers.BootstrapEditorRowFor(c => c.AccountID);
                                                            }

                                                            var AccountBalance = ColNoContentDiv.Helpers.DivC("col-md-12");
                                                            {
                                                                UserAccount.Helpers.BootstrapEditorRowFor(c => c.Balance);
                                                            }
                                                            var AccountType = ColNoContentDiv.Helpers.DivC("col-md-12");
                                                            {
                                                                // UserAccount.Helpers.BootstrapEditorRowFor(c => c.AccountTypeID);
                                                            }
                                                            var ActionsDiv = ColNoContentDiv.Helpers.DivC("col-md-12");
                                                            {

                                                                var SaveBtns = ActionsDiv.Helpers.Button("Deposit Funds", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                                {
                                                                    SaveBtns.AddClass("btn btn-success btn-success");
                                                                    SaveBtns.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveAccount($data)");
                                                                }


                                                                var Addtn = ActionsDiv.Helpers.Button("Buy", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                                {
                                                                    Addtn.AddBinding(Singular.Web.KnockoutBindingString.click, "Home()");
                                                                    Addtn.AddClass("btn btn-success btn-outline");
                                                                }


                                                            }
                                                        }


                                                    }
                                                    var aToolsTag = CardTitleToolsDiv.Helpers.HTMLTag("a");
                                                    aToolsTag.AddClass("collapse-link");
                                                    {
                                                        var iToolsTag = aToolsTag.Helpers.HTMLTag("i");
                                                        iToolsTag.AddClass("fa fa-chevron-up");
                                                    }
                                                }
                                            }
                                            #endregion
                                            #region Right Column / Data
                                            var RowColRight = RowContentDiv.Helpers.DivC("col-md-4");
                                            {
                                            }
                                            #endregion
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

        var Home = function () {
            window.location = '../Account/Home.aspx';
        }


        function SaveAccount(data) {
            ViewModel.CallServerMethod('SaveAccountList', { Account: ViewModel.AccountList.Serialise(), ShowLoadingBar: true }, function (result) {
                if (result.Success) {
                    Singular.ShowMessage('Save', 'Successfully Saved',900000000000000000);
                    location.reload();
                }
                else {
                    MEHelpers.Notification(result.ErrorText, 'center', 'warning', 900000000000000000);
                    //Singular.ShowMessage('Error', result.ErrorText);
                    location.reload();
                }
            });
        }



    </script>
</asp:Content>
