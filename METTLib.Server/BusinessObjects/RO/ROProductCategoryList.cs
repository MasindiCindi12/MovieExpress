using System;
using Csla;
using Csla.Serialization;
using Csla.Data;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace MELib.RO
{
    [Serializable]
    public class ROProductCategoryList : MEReadOnlyListBase<ROProductCategoryList, ROProductCategory>
    {
        #region " Business Methods "

        public ROProductCategory GetItem(int CategoryID)
        {
            foreach (ROProductCategory child in this)
            {
                if (child.CategoryID == CategoryID)
                {
                    return child;
                }
            }
            return null;
        }

        public override string ToString()
        {
            return "Product Category";
        }

        #endregion

        #region " Data Access "

        [Serializable]
        public class Criteria : CriteriaBase<Criteria>
        {

           public int? CategoryID = null;
            public Criteria()
            {
            }

        }

        public static ROProductCategoryList NewROProductCategoryList()
        {
            return new ROProductCategoryList();
        }

        public ROProductCategoryList()
        {
            // must have parameter-less constructor
        }

        public static ROProductCategoryList GetROProductCategoryList()
        {
            return DataPortal.Fetch<ROProductCategoryList>(new Criteria());
        }


        public static ROProductCategoryList GetROProductCategoryList(int? CategoryID)
        {
            return DataPortal.Fetch<ROProductCategoryList>(new Criteria { CategoryID = CategoryID });
        }
        protected void Fetch(SafeDataReader sdr)
        {
            this.RaiseListChangedEvents = false;
            this.IsReadOnly = false;
            while (sdr.Read())
            {

                this.Add(ROProductCategory.GetROProductCategory(sdr));
              
            }
            this.IsReadOnly = true;
            this.RaiseListChangedEvents = true;
        }

        protected override void DataPortal_Fetch(Object criteria)
        {
            Criteria crit = (Criteria)criteria;
            using (SqlConnection cn = new SqlConnection(Singular.Settings.ConnectionString))
            {
                cn.Open();
                try
                {
                    using (SqlCommand cm = cn.CreateCommand())
                    {
                        cm.CommandType = CommandType.StoredProcedure;
                        //cm.CommandText = "GetProcs.getCategoryList";
                        cm.CommandText = "GetProcs.getCategoryProductList";
                        cm.Parameters.AddWithValue("@CategoryID", Singular.Misc.NothingDBNull(crit.CategoryID));
                        using (SafeDataReader sdr = new SafeDataReader(cm.ExecuteReader()))
                        {
                            Fetch(sdr);
                        }
                    }
                }
                finally
                {
                    cn.Close();
                }
            }
        }

        #endregion



    }
}
