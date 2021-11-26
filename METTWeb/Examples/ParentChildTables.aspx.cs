using System;
using Singular.Web;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web.Data;
using MELib;
using MELib.Security;
using Singular;
using MELib.Categories;
using MELib.Helpers;
using Csla;
using System.Data;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace MEWeb.Examples
{

  public partial class ParentChildTables : MEPageBase<ParentChildTablesVM>
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
  public class ParentChildTablesVM : MEStatelessViewModel<ParentChildTablesVM>
  {
    public CategoryList CategoriesList { get; set; }
    public SubCategoryList SubCategoriesList { get; set; }


       // public MELib.Products.ProductList ProductListing { get; set; }
        public ParentChildTablesVM()
    {

    }

    protected override void Setup()
    {
      base.Setup();

      CategoriesList = MELib.Categories.CategoryList.GetCategoryList();
           // ProductListing = MELib.Categories..ProductList.GetProductList();
    }

		[WebCallable]
		public Result SaveCategoryList(MELib.Categories.CategoryList CategoryList)
		{
			Result sr = new Result();
			if (CategoryList.IsValid)
			{
				var SaveResult = CategoryList.TrySave();
				if (SaveResult.Success)
				{
					sr.Data = SaveResult.SavedObject;
					sr.Success = true;
				}
				else
				{
					sr.ErrorText = SaveResult.ErrorText;
					sr.Success = false;
				}
				return sr;
			}
			else
			{
				sr.ErrorText = CategoriesList.GetErrorsAsHTMLString();
				return sr;
			}
		}
	}
}


