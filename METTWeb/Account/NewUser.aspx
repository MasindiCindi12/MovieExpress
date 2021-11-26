<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewUser.aspx.cs" Inherits="MEWeb.Account.NewUser" %>
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
							var HomeContainerTab = AssessmentsTab.AddTab("Change Password");
							{
								var StatisticsRow = HomeContainerTab.Helpers.DivC("row");
								{
									var CardColumnOne = StatisticsRow.Helpers.DivC("col-md-12");
									{
										CardColumnOne.Helpers.HTML().Heading2("Change Password");
										CardColumnOne.Helpers.HTML("Please complete the required fields below to change your old password to a new password.");

										h.MessageHolder();

										var EditPasswordDiv = CardColumnOne.Helpers.DivC("row");
										{
											{
												var UserContent = EditPasswordDiv.Helpers.With<ChangePasswordVM.ChangeDetails>((c) => c.Details);
												{
													var FirstName = UserContent.Helpers.DivC("col-md-12 form-control text-center");
													{
														FirstName.Helpers.HTML("<p>First Name</p>");
														FirstName.Helpers.EditorFor(c => c.OldPassword);
													}
													var LastName = UserContent.Helpers.DivC("col-md-12 paddingTop24");
													{
														LastName.Helpers.HTML("<p>Last Name</p>");
														LastName.Helpers.EditorFor(c => c.NewPassword);
													}
													var Username = UserContent.Helpers.DivC("col-md-12 paddingTop24");
													{
														Username.Helpers.HTML("<p>User Name</p>");
														Username.Helpers.EditorFor(c => c.ConfirmPassword);
													}

													var EmailAddress = UserContent.Helpers.DivC("col-md-12 paddingTop24");
													{
														EmailAddress.Helpers.HTML("<p>Last Name</p>");
														EmailAddress.Helpers.EditorFor(c => c.NewPassword);
													}

													var ContactNo = UserContent.Helpers.DivC("col-md-12 paddingTop24");
													{
														ContactNo.Helpers.HTML("<p>Last Name</p>");
														ContactNo.Helpers.EditorFor(c => c.NewPassword);
													}
													var NewPasswordConfirm = UserContent.Helpers.DivC("col-md-12 paddingTop24");
													{
														NewPasswordConfirm.Helpers.HTML("<p>Confirm Password</p>");
														NewPasswordConfirm.Helpers.EditorFor(c => c.ConfirmPassword);
													}
													var OkButton = UserContent.Helpers.DivC("col-md-12 paddingTop24");
													{
														var button = OkButton.Helpers.Button("Change Password", Singular.Web.ButtonMainStyle.Success, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
														{
															button.AddBinding(Singular.Web.KnockoutBindingString.click, "ChangePassword()");
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

		function ChangePassword() {
			Singular.Validation.IfValid(ViewModel.Details(), function () {
				ViewModel.CallServerMethod('ChangePassword', { Details: ViewModel.Details.Serialise() }, function (data) {
					Singular.AddMessage(data.Item1 - 1, 'Change Password', data.Item2).Fade(2000);
					if (data.Item1 == 4) {
					window.location = "Home.aspx";
					}
					
				}, true);
			});
		}
    </script>



</asp:Content>
