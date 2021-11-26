<%@ Page Title="Log In" Language="C#" MasterPageFile="~/SiteLoggedOut.Master" AutoEventWireup="false" CodeBehind="Login.aspx.cs" Inherits="MEWeb.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent1">
  <link href="../Theme/Singular/Custom/loggedout.css" rel="stylesheet" />
  <link href="../Theme/Singular/css/loginandlockscreen.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent1">
  <%
      using (var h = this.Helpers)
      {
          var toolbar = h.Toolbar();
          {
              toolbar.Helpers.HTML().Heading2("Log In");
              toolbar.Helpers.HTML("<p>Please enter your email address and password.</p>");
              //toolbar.Helpers.HTML("<p>Default Administrator:<b>SuperU</b> Password: <b>p</b></p>");
              //toolbar.Helpers.HTML("<p>Normal User: <b>User</b> Password: <b>p</b></p>");
              toolbar.AddBinding(Singular.Web.KnockoutBindingString.visible, c => !c.ShowForgotPasswordInd);
          }
          h.MessageHolder();
          var LoginDiv = h.Div();
          {
              LoginDiv.AddBinding(Singular.Web.KnockoutBindingString.visible, c => !c.ShowForgotPasswordInd);

              var fieldSet = LoginDiv.Helpers.FieldSetFor<Singular.Web.Security.LoginDetails>("Account Information", c => c.LoginDetails);
              {
                  fieldSet.AddClass("StackedEditors SUI-RuleBorder");
                  fieldSet.Style["max-width"] = "420px";
                  var EmailAddressrow = fieldSet.Helpers.DivC("row");
                  {
                      var EmailLabel = EmailAddressrow.Helpers.HTMLTag("label", "Email Address");
                      EmailAddressrow.Helpers.EditorFor(c => c.UserName);
                  }
                  fieldSet.Helpers.EditorRowFor(c => c.Password);
                  var row = fieldSet.Helpers.DivC("row");
                  {
                  }
              }
              var Loginbutton = LoginDiv.Helpers.Button("Login", "Log In");
              {
                  Loginbutton.AddBinding(Singular.Web.KnockoutBindingString.click, "Login()");
                  Loginbutton.AddClass("btn btn-success btn-success");
                  Loginbutton.ClickOnEnterKey = true;
              }
              var ForgotPasswordBtn = LoginDiv.Helpers.Button("", "Forgot Password");
              {
                  ForgotPasswordBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "ShowFP()");
              }
              var SignUpBtn = LoginDiv.Helpers.Button("", "Sign Up");
              {
                  SignUpBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "SignUpUsers()");
                  SignUpBtn.AddClass("btn btn-success btn-outline");
              }
             
          }
          var ForgotPasswordDiv = h.Div();
          {
              ForgotPasswordDiv.AddBinding(Singular.Web.KnockoutBindingString.visible, c => c.ShowForgotPasswordInd);
              var FPtoolbar = ForgotPasswordDiv.Helpers.Toolbar();
              {
                  FPtoolbar.Helpers.HTML().Heading2("Forgot Password");
              }
              var FPDetailsDiv = ForgotPasswordDiv.Helpers.DivC("m-t-md");
              FPDetailsDiv.Helpers.BootstrapEditorRowFor(c => c.ForgotEmail);
              var FPButtons = ForgotPasswordDiv.Helpers.DivC("m-t-md");
              {
                  var FPback = FPButtons.Helpers.Button("Back", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                  {
                      FPback.AddBinding(Singular.Web.KnockoutBindingString.click, "ShowFP()");
                      FPback.AddClass("MarginRight1");
                  }
                  var FPReset = FPButtons.Helpers.Button("Reset Password", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                  {
                      FPReset.AddBinding(Singular.Web.KnockoutBindingString.click, "FPReset()");
                  }


              }
          }


      }
  %>

  <script type="text/javascript">


      var SignUpUsers = function () {
          window.location = '../Account/NewUserRegistrations.aspx';
      }

  

    function Login() {
      Singular.Validation.IfValid(ViewModel, function () {
        Singular.ShowLoadingBar();
        ViewModel.CallServerMethod('Login', { LoginDetails: ViewModel.LoginDetails.Serialise() }, function (result) {
          if (result.Success) {
            window.location = result.Data ? result.Data : ViewModel.RedirectLocation();
            Singular.HideLoadingBar();
          } else {
            ViewModel.LoginDetails().Password('');
              Singular.AddMessage(1, 'Login', result.ErrorText).Fade(900000);
            Singular.HideLoadingBar();
          }
        });
      });
    }

      //function SignUp() {
      //    Singular.Validation.IfValid(ViewModel, function () {
      //        Singular.ShowLoadingBar();
      //        ViewModel.CallServerMethod('SignUp', { LoginDetails: ViewModel.LoginDetails.Serialise() }, function (result) {
      //            if (result.Success) {
      //                window.location = result.Data ? result.Data : ViewModel.RedirectLocation();
      //                Singular.HideLoadingBar();
      //            } else {
      //                ViewModel.LoginDetails().Password('');
      //                Singular.AddMessage(1, 'SignUp', result.ErrorText).Fade(2000);
      //                Singular.HideLoadingBar();
      //            }
      //        });
      //    });
      //}
    var ShowFP = function () {
      ViewModel.ShowForgotPasswordInd(!ViewModel.ShowForgotPasswordInd());
    };

    var FPReset = function () {
      METTHelpers.QuestionDialogYesNo(("Are you sure you would like to reset your password?"), 'center',
        function () {
          Singular.ShowLoadingBar();
          ViewModel.CallServerMethod('ResetPassword', { Email: ViewModel.ForgotEmail() }, function (result) {
            Singular.HideLoadingBar();
            if (result.Success) {
              METTHelpers.Notification('Please check your email for reset instructions', 'center', 'success', 5000);
              ViewModel.ShowForgotPasswordInd(false);
              ViewModel.ForgotEmail("");
            } else {
              ViewModel.ShowForgotPasswordInd(false);
              ViewModel.ForgotEmail("");
            }
          })
        },
        function () {
          ViewModel.ShowForgotPasswordInd(false);
          ViewModel.ForgotEmail("");
        });
    };
  </script>
</asp:Content>
