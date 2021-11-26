<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductTable.aspx.cs" Inherits="MEWeb.Examples.ProductTable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="../Scripts/JSLINQ.js"></script>
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
                             var HomeContainerTab = AssessmentsTab.AddTab("Product Management");
                             {
                                 var Row = HomeContainerTab.Helpers.DivC("row margin0");
                                 {
                                     var RowCol = Row.Helpers.DivC("col-md-12");
                                     {
                                         RowCol.Helpers.HTML().Heading2("Edit Products");



                                         var ProductList = RowCol.Helpers.TableFor<MELib.Products.Product>((c) => c.ProductList, true, true);
                                         {
                                             ProductList.AddClass("table table-striped table-bordered table-hover");
                                             var ProductListRow = ProductList.FirstRow;
                                             {
                                                 var ProductName = ProductListRow.AddColumn(c => c.ProductName);
                                                 {
                                                     ProductName.Style.Width = "200px";
                                                 }
                                                 var ProductCategory = ProductListRow.AddColumn(c => c.CategoryID);
                                                 {
                                                     ProductCategory.Style.Width = "200px";
                                                 }

                                                 var ProductDescription = ProductListRow.AddColumn(c => c.ProductDescription);
                                                 {
                                                     ProductDescription.Style.Width = "400px";
                                                 }

                                                 var ProductImage = ProductListRow.AddColumn(c => c.ProductImageURL);
                                                 {
                                                  
                                                     var ProductImagePath = ProductImage.Helpers.ImageChooser(c => c.ProductImageURL, 10, 10, 10, "Choose Product Image");
                                                     {
                                                         ProductImagePath.Helpers.Image();
                                                     }

                                                 }
                                                 var ProductPrice = ProductListRow.AddColumn(c => c.Price);
                                                 {
                                                     ProductPrice.Style.Width = "80px";
                                                 }
                                                 var ProductQuantity = ProductListRow.AddColumn(c => c.Quantity);
                                                 {
                                                     ProductQuantity.Style.Width = "80px";
                                                 }
                                                 var StockedDate = ProductListRow.AddColumn(c => c.StockedDate);
                                                 {
                                                     StockedDate.Style.Width = "175px";
                                                 }
                                                 var ProductAvailability = ProductListRow.AddColumn(c => c.IsActiveInd);
                                                 {
                                                     ProductAvailability.Style.Width = "175px";
                                                 }

                                             }

                                             var SaveList = RowCol.Helpers.DivC("col-md-12 text-right");
                                             {
                                                 var SaveBtn = SaveList.Helpers.Button("Save", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                 {
                                                     SaveBtn.AddClass("btn btn-success btn-success");
                                                     SaveBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveProducts($data)");
                                                 }
                                             }

                                         }
                                     }
                                    
                                 }

                                 var CategoryContainerTab = AssessmentsTab.AddTab("Category Management");
                                 {
                                     var Rows = CategoryContainerTab.Helpers.DivC("row margin0");
                                     {
                                         var RowCols = Rows.Helpers.DivC("col-md-8");
                                         {
                                             RowCols.Helpers.HTML().Heading2("Edit Category");
                                             var CategoryList = RowCols.Helpers.TableFor<MELib.Categories.Category>((c) => c.CategoryList, true, true);
                                             {
                                                 CategoryList.AddClass("table table-striped table-bordered table-hover");
                                                 var ProductListRows = CategoryList.FirstRow;
                                                 {
                                                     var ProductName = ProductListRows.AddColumn(c => c.CategoryName);
                                                     {
                                                         ProductName.Style.Width = "600px";
                                                     }
                                                     var ProductCategory = ProductListRows.AddColumn(c => c.IsActiveInd);
                                                     {
                                                         ProductCategory.Style.Width = "200px";
                                                     }


                                                 }
                                             }

                                             var SaveList = RowCols.Helpers.DivC("col-md-12 text-right");
                                             {
                                                 var SaveBtn = SaveList.Helpers.Button("Save", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                 {
                                                     SaveBtn.AddClass("btn btn-success btn-success");
                                                     SaveBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveCategories($data)");
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
      $("#menuItem5").addClass("active");
      $("#menuItem5 > ul").addClass("in");
    });

    var SaveProducts = function (obj) {
        ViewModel.CallServerMethod('SaveProductList', { ProductList: ViewModel.ProductList.Serialise(), ShowLoadingBar: true }, function (result) {
        if (result.Success) {
            MEHelpers.Notification("Successfully Saved", 'center', 'success', 3000);
            location.reload();
        }
        else {
          MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
        }
      });
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
