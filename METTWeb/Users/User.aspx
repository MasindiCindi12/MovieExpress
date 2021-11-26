<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="MEWeb.Users.User" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

   <%
       using (var h = this.Helpers)
       {
           var toolbar = h.Toolbar();
           {
               toolbar.Helpers.HTML().Heading2("Register");
               toolbar.AddBinding(Singular.Web.KnockoutBindingString.visible, c => !c.ShowForgotPasswordInd);
           }
           /*          h.MessageHolder();
                     var RegisterDiv = h.Div();
                     {
                       RegisterDiv.AddBinding(Singular.Web.KnockoutBindingString.visible, c => !c.ShowForgotPasswordInd);

                         var fieldSet = RegisterDiv.Helpers.FieldSetFor<Singular.Web.Security.LoginDetails>("Person Information",c => c.LoginDetails);
                         {
                             fieldSet.AddClass("StackedEditors SUI-RuleBorder");
                             fieldSet.Style["max-width"] = "420px";

                             var FirstNameRow = fieldSet.Helpers.DivC("row");
                             {
                                 var FirstName = FirstNameRow.Helpers.HTMLTag("label", "First Name");
                                 FirstNameRow.Helpers.EditorFor(c => c.UserName);
                             }
                             var LastNameRow = fieldSet.Helpers.DivC("row");
                             {
                                 var LastName = LastNameRow.Helpers.HTMLTag("label", "Last Name");
                                 LastNameRow.Helpers.EditorFor(c => c.UserName);
                             }

                             var UserNameRow = fieldSet.Helpers.DivC("row");
                             {
                                 var UserName = UserNameRow.Helpers.HTMLTag("label", "Last Name");
                                 UserNameRow.Helpers.EditorFor(c => c.UserName);
                             }
                             var PasswordRow = fieldSet.Helpers.DivC("row");
                             {
                                 var Password = PasswordRow.Helpers.HTMLTag("label", "Last Name");
                                 PasswordRow.Helpers.EditorFor(c => c.UserName);
                             }
                             var SaltRow = fieldSet.Helpers.DivC("row");
                             {
                                 var Salt = SaltRow.Helpers.HTMLTag("label", "Last Name");
                                 SaltRow.Helpers.EditorFor(c => c.UserName);
                             }
                             var EmailAddressRow = fieldSet.Helpers.DivC("row");
                             {
                                 var EmailAddress = EmailAddressRow.Helpers.HTMLTag("label", "Last Name");
                                 EmailAddressRow.Helpers.EditorFor(c => c.UserName);
                             }
                             var JobDescriptionRow = fieldSet.Helpers.DivC("row");
                             {
                                 var JobDescription = JobDescriptionRow.Helpers.HTMLTag("label", "Last Name");
                                 JobDescriptionRow.Helpers.EditorFor(c => c.UserName);
                             }
                             var CreatedDateRow = fieldSet.Helpers.DivC("row");
                             {
                                 var CreatedDate = CreatedDateRow.Helpers.HTMLTag("label", "Last Name");
                                 CreatedDateRow.Helpers.EditorFor(c => c.UserName);
                             }
                             var CreatedByRow = fieldSet.Helpers.DivC("row");
                             {
                                 var CreatedBy = CreatedByRow.Helpers.HTMLTag("label", "Last Name");
                                 CreatedByRow.Helpers.EditorFor(c => c.UserName);
                             }
                         }
                     }
                 }*/

       }
           %>
</asp:Content>
