<%@ Page Title="" Language="C#" MasterPageFile="~/SiteLoggedOut.Master" AutoEventWireup="true" CodeBehind="Deposit.aspx.cs" Inherits="MEWeb.Profile.Deposit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent1" runat="server">

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
                              var HomeContainerTab = AssessmentsTab.AddTab("Deposit Account Funds");
                              {
                                  var Row = HomeContainerTab.Helpers.DivC("row margin0");
                                  {
                                      var RowCol = Row.Helpers.DivC("col-md-12");
                                      {
                                         

                                         
                                              var ContentDiv = RowCol.Helpers.DivC("ibox-content");
                                              {
                                                  var RowContentDiv = ContentDiv.Helpers.DivC("row");
                                                  {
                                                      var LeftColContentDiv = RowContentDiv.Helpers.DivC("col-md-1");
                                                      {
                                                          // Place holder
                                                      }

                                                      var MiddlerColContentDiv = RowContentDiv.Helpers.DivC("col-md-10");
                                                      {
                                                          var FormContent = MiddlerColContentDiv.Helpers.With<MELib.Accounts.Account>(c => c.myAccount);
                                                          {
                                                              var UserFirstName = FormContent.Helpers.DivC("col-md-12");
                                                              {
                                                                  UserFirstName.Helpers.BootstrapEditorRowFor(c => c.UserID);
                                                              }
                                                              var UserSurname = FormContent.Helpers.DivC("col-md-12");
                                                              {
                                                                  UserSurname.Helpers.BootstrapEditorRowFor(c => c.AccountTypeID);
                                                              }

                                                              var UserUsername = FormContent.Helpers.DivC("col-md-12");
                                                              {
                                                                  UserUsername.Helpers.BootstrapEditorRowFor(c => c.Balance);
                                                              }


                                                              
                                                              var ActionsDiv = FormContent.Helpers.DivC("col-md-12");
                                                              {

                                                                  var SaveBtn = ActionsDiv.Helpers.Button("Deposit Funds", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.money);
                                                                  {
                                                                      SaveBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "DepositFunds($data)");
                                                                      SaveBtn.AddClass("btn btn-success");
                                                                  }
                                                                  var LogBtn = ActionsDiv.Helpers.Button("   Login", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Small, Singular.Web.FontAwesomeIcon.arrow_circle_o_left);
                                                                  {
                                                                      SaveBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "Login()");
                                                                      SaveBtn.AddClass("btn btn-outline");
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
      $("#menuItem4").addClass("active");
      $("#menuItem4 > ul").addClass("in");
    });

      var SavingUser = function (obj) {
          ViewModel.CallServerMethod('SaveUser', { UserList: ViewModel.UserList.Serialise(), ShowLoadingBar: true }, function (result) {
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
