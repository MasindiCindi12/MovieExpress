using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular;
using Singular.Web;

namespace MEWeb.Examples
{
    public partial class ProductTable : MEPageBase<ProductTableVM>
    {

    }
    public class ProductTableVM : MEStatelessViewModel<ProductTableVM>
    {
        public MELib.Products.ProductList ProductList { get; set; }

		//product category
		//public MELib.RO.ROProductList roproduct { get; set; }
		public MELib.Categories.CategoryList CategoryList { get; set; }
		public MELib.Categories.SubCategoryList SubCategoryList { get; set; }
        public ProductTableVM()
        {

        }

        protected override void Setup()
        {
            base.Setup();
            ProductList = MELib.Products.ProductList.GetProductList();
			CategoryList = MELib.Categories.CategoryList.GetCategoryList();
			//SubCategoryList = MELib.Categories.SubCategoryList.Get();
			//roproduct = MELib.RO.ROProductList.GetProductList();//
        }

		[WebCallable]
		public Result SaveProductList(MELib.Products.ProductList ProductList)
		{
			Result sr = new Result();
			if (ProductList.IsValid)
			{
				var SaveResult = ProductList.TrySave();
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
				sr.ErrorText = ProductList.GetErrorsAsHTMLString();
				return sr;
			}
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
				sr.ErrorText = ProductList.GetErrorsAsHTMLString();
				return sr;
			}
		}

	}


}