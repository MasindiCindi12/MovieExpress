<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BasicUser.aspx.cs" Inherits="MEWeb.Profile.BasicUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
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
                          var HomeContainerTab = AssessmentsTab.AddTab("Profile");
                          {
                              var Row = HomeContainerTab.Helpers.DivC("row margin0");
                              {
                                  var RowCol = Row.Helpers.DivC("col-md-12");
                                  {
                                      //RowCol.Helpers.HTML().Heading2("Edit Profile");
                                      // RowCol.Helpers.HTMLTag("br/");

                                      var CardDiv = RowCol.Helpers.DivC("ibox float-e-margins paddingBottom");
                                      {
                                          var CardTitleDiv = CardDiv.Helpers.DivC("ibox-title");
                                          {
                                              CardTitleDiv.Helpers.HTML("<i class='fa fa-book fa-lg fa-fw pull-left'></i>");
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
                                                  var LeftColContentDiv = RowContentDiv.Helpers.DivC("col-md-4");
                                                  {
                                                      // Place holder
                                                  }

                                                  var MiddlerColContentDiv = RowContentDiv.Helpers.DivC("col-md-4");
                                                  {
                                                      var FormContent = MiddlerColContentDiv.Helpers.With<MELib.Security.UserList>(c => c.UserList);
                                                      {
                                                          var UserFirstName = FormContent.Helpers.DivC("col-md-12");
                                                          {
                                                              UserFirstName.Helpers.BootstrapEditorRowFor(c => c.FirstOrDefault().FirstName);
                                                          }
                                                          var UserSurname = FormContent.Helpers.DivC("col-md-12");
                                                          {
                                                              UserSurname.Helpers.BootstrapEditorRowFor(c => c.FirstOrDefault().Surname);
                                                          }

                                                          var UserUsername = FormContent.Helpers.DivC("col-md-12");
                                                          {
                                                              UserUsername.Helpers.BootstrapEditorRowFor(c => c.FirstOrDefault().LoginName);
                                                          }


                                                          var UserEmail = FormContent.Helpers.DivC("col-md-12");
                                                          {
                                                              UserEmail.Helpers.BootstrapEditorRowFor(c => c.FirstOrDefault().EmailAddress);
                                                          }


                                                          var UserContact = FormContent.Helpers.DivC("col-md-12");
                                                          {
                                                              UserContact.Helpers.BootstrapEditorRowFor(c => c.FirstOrDefault().ContactNumber);
                                                          }

                                                          var UserJobDescription = FormContent.Helpers.DivC("col-md-12");
                                                          {
                                                              UserJobDescription.Helpers.BootstrapEditorRowFor(c => c.FirstOrDefault().JobDescription);
                                                          }

                                                          var UserPassword = FormContent.Helpers.DivC("col-md-12");
                                                          {
                                                              UserPassword.Helpers.BootstrapEditorRowFor(c => c.FirstOrDefault().Password);
                                                          }
                                                         
                                                          var ActionsDiv = FormContent.Helpers.DivC("col-md-12");
                                                          {

                                                              var SaveBtn = ActionsDiv.Helpers.Button("Update Profile", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                              {
                                                                  SaveBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "UpdateProfile($data)");
                                                                  SaveBtn.AddClass("btn btn-success");
                                                              }

                                                             


                                                          }
                                                      }
                                                  }



                                                  var RightColContentDiv = RowContentDiv.Helpers.DivC("col-md-4");
                                                  {
                                                      // Place holder
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

      var UpdateProfile = function (obj) {
          ViewModel.CallServerMethod('UpdateProfile', { UserList: ViewModel.UserList.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  MEHelpers.Notification("Successfully Saved", 'center', 'success', 3000);
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          });
      }

    var DeleteMovie = function (obj) {
      MEHelpers.QuestionDialogYesNo("Are you sure you would like to delete this item?", 'center',
        function () { // Yes
          ViewModel.CallServerMethod('DeleteMovie', { MovieID: obj.MovieID(), ShowLoadingBar: true }, function (result) {
          	if (result.Success) {
          MEHelpers.Notification("Item deleted successfully.", 'center', 'success', 5000);
          	}
          	else {
          		MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
          	}
          })
        },
        function () { // No
        })
    };

      var UpdateProfile = function (obj) {
          ViewModel.CallServerMethod('UpdateProfile', { UserList: ViewModel.UserList.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  MEHelpers.Notification("Successfully Saved", 'center', 'success', 3000);
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          });
      }

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

      //New User

      var SaveUser = function (obj) {
          ViewModel.CallServerMethod('SaveUser', { UserList: ViewModel.UserList.Serialise(), ShowLoadingBar: true }, function (result) {

         // ViewModel.CallServerMethod('SaveUser', { FirstName: obj.FirstName(), LastName: obj.LastName(), UserName: obj.UserName(), ContactNo: obj.ContactNo(), EmailAddress: obj.EmailAddress(), ShowLoadingBar: true }, function (result) {
                  if (result.Success) {
                      ViewModel.UserListPageManager().Refresh();
                      ViewModel.EditingUser.Clear();

                      METTHelpers.Notification("User has been saved successfully", 'center', 'success', 5000);
                  } else {

                      METTHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                  }
              });
          };
      

  </script>

</asp:Content>
