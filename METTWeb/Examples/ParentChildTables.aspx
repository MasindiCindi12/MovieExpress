<%@ Page Title="Popcorn" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ParentChildTables.aspx.cs" Inherits="MEWeb.Examples.ParentChildTables" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  <!-- Add page specific Styles and JavaScript classes below -->
  <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
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
                          var HomeContainerTab = AssessmentsTab.AddTab("Categories Management");
                          {
                              var Row = HomeContainerTab.Helpers.DivC("row margin0");
                              {
                                  var RowCol = Row.Helpers.DivC("col-md-12");
                                  {
                                      RowCol.Helpers.HTML().Heading3("Categories/Sub Categories");
                                      #region Categories

                                      var CategoriesDiv = RowCol.Helpers.Div();
                                      {
                                          var Categories = CategoriesDiv.Helpers.BootstrapTableFor<MELib.Categories.Category>((c) => c.CategoriesList, false, false, "", true);
                                          var CategoriesFirstRow = Categories.FirstRow;
                                          {
                                              var CategoryName = CategoriesFirstRow.AddReadOnlyColumn(c => c.CategoryName);
                                              {
                                                  CategoryName.HeaderText = "Threat Category";
                                              }
                                          }

                                          var SubCategories = Categories.AddChildTable<MELib.Categories.SubCategory>((c) => c.SubCategoryList, false, false, "");
                                          {
                                              var SubCategoriesFirstRow = SubCategories.FirstRow;
                                              {
                                                  var SubCategoryName = SubCategoriesFirstRow.AddColumn(c => c.SubCategoryName);
                                                  {
                                                  }
                                                  var SubCategoryDescription = SubCategoriesFirstRow.AddColumn(c => c.SubCategoryDescription);
                                                  {
                                                      SubCategoryDescription.HeaderText = "Description";
                                                  }
                                              }
                                              var EditCol = SubCategoriesFirstRow.AddColumn("Action");
                                              {
                                                  // Specify the column width - this can be done in various ways, one example below;
                                                  EditCol.Attributes.Add("style", "width:150px;text-align: center;");

                                                  // Add Action Buttons Here
                                                  var EditBtn = EditCol.Helpers.Button("Edit", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                  {
                                                      EditBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveCategories($data)");
                                                      EditBtn.AddClass("btn btn-success btn-outline");
                                                  }

                                                  var DeleteBtn = EditCol.Helpers.Button("Delete", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                  {
                                                      DeleteBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveCategories($data)");
                                                      DeleteBtn.AddClass("btn btn-success btn-outline");
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
    Singular.OnPageLoad(function () {
      $("#menuItem5").addClass("active");
      $("#menuItem5 > ul").addClass("in");
    });

    var DoSomething = function (obj) {
      alert('You can write code to edit/delete this object [' + obj.SubCategoryName() + ']!');
    }

      var SaveCategories = function (obj) {
          ViewModel.CallServerMethod('SaveCategoryList', { CategoryList: ViewModel.CategoryList.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  MEHelpers.Notification("Category Successfully Added.", 'center', 'success', 3000);
                  location.reload();
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          });
      }

  </script>
</asp:Content>
