using Csla;
using Csla.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MELib.RO
{
    [Serializable]
   public class ROProductCategory : MEReadOnlyBase<ROProductCategory>
    {
        #region " Properties and Methods "

        #region " Properties "

        public static PropertyInfo<int> ProductCategoryIDProperty = RegisterProperty<int>(c => c.CategoryID, "ID", 0);
        /// <summary>
        /// Gets the ID value
        /// </summary>
        [Display(AutoGenerateField = false), Key]
        public int CategoryID
        {
            get { return GetProperty(ProductCategoryIDProperty); }
        }

        public static PropertyInfo<String> CategoryProperty = RegisterProperty<String>(c => c.CategoryName, "CategoryName", "");
        /// <summary>
        /// Gets the Genre value
        /// </summary>
        [Display(Name = "Category", Description = "")]
        public String CategoryName
        {
            get { return GetProperty(CategoryProperty); }
        }

        public static PropertyInfo<Boolean> IsActiveIndProperty = RegisterProperty<Boolean>(c => c.IsActiveInd, "Is Active", true);
        /// <summary>
        /// Gets the Is Active value
        /// </summary>
        [Display(Name = "Is Active", Description = "Indicator showing if the Product is Active")]
        public Boolean IsActiveInd
        {
            get { return GetProperty(IsActiveIndProperty); }
        }

        public static PropertyInfo<DateTime?> DeletedDateProperty = RegisterProperty<DateTime?>(c => c.DeletedDate, "Deleted Date");
        /// <summary>
        /// Gets the Deleted Date value
        /// </summary>
        [Display(Name = "Deleted Date", Description = "When this record was deleted")]
        public DateTime? DeletedDate
        {
            get
            {
                return GetProperty(DeletedDateProperty);
            }
        }

        public static PropertyInfo<int> DeletedByProperty = RegisterProperty<int>(c => c.DeletedBy, "Deleted By", 0);
        /// <summary>
        /// Gets the Deleted By value
        /// </summary>
        [Display(Name = "Deleted By", Description = "User that deleted the record")]
        public int DeletedBy
        {
            get { return GetProperty(DeletedByProperty); }
        }

        public static PropertyInfo<SmartDate> CreatedDateProperty = RegisterProperty<SmartDate>(c => c.CreatedDate, "Created Date", new SmartDate(DateTime.Now));
        /// <summary>
        /// Gets the Created Date value
        /// </summary>
        [Display(AutoGenerateField = false)]
        public SmartDate CreatedDate
        {
            get { return GetProperty(CreatedDateProperty); }
        }

        public static PropertyInfo<int> CreatedByProperty = RegisterProperty<int>(c => c.CreatedBy, "Created By", 0);
        /// <summary>
        /// Gets the Created By value
        /// </summary>
        [Display(AutoGenerateField = false)]
        public int CreatedBy
        {
            get { return GetProperty(CreatedByProperty); }
        }

        public static PropertyInfo<SmartDate> ModifiedDateProperty = RegisterProperty<SmartDate>(c => c.ModifiedDate, "Modified Date", new SmartDate(DateTime.Now));
        /// <summary>
        /// Gets the Modified Date value
        /// </summary>
        [Display(AutoGenerateField = false)]
        public SmartDate ModifiedDate
        {
            get { return GetProperty(ModifiedDateProperty); }
        }

        public static PropertyInfo<int> ModifiedByProperty = RegisterProperty<int>(c => c.ModifiedBy, "Modified By", 0);
        /// <summary>
        /// Gets the Modified By value
        /// </summary>
        [Display(AutoGenerateField = false)]
        public int ModifiedBy
        {
            get { return GetProperty(ModifiedByProperty); }
        }

        #endregion

        #region " Methods "

        protected override object GetIdValue()
        {
            return GetProperty(ProductCategoryIDProperty);
        }

        public override string ToString()
        {
            return this.CategoryName;
        }

        #endregion

        #endregion

        #region " Data Access & Factory Methods "

        internal static ROProductCategory GetROProductCategory(SafeDataReader dr)
        {
            var r = new ROProductCategory();
            r.Fetch(dr);
            return r;
        }

        protected void Fetch(SafeDataReader sdr)
        {
            int i = 0;
            LoadProperty(ProductCategoryIDProperty, sdr.GetInt32(i++));
            LoadProperty(CategoryProperty, sdr.GetString(i++));
            LoadProperty(IsActiveIndProperty, sdr.GetBoolean(i++));
            LoadProperty(DeletedDateProperty, sdr.GetSmartDate(i++));
            LoadProperty(DeletedByProperty, sdr.GetInt32(i++));
            LoadProperty(CreatedDateProperty, sdr.GetSmartDate(i++));
            LoadProperty(CreatedByProperty, sdr.GetInt32(i++));
            LoadProperty(ModifiedDateProperty, sdr.GetSmartDate(i++));
            LoadProperty(ModifiedByProperty, sdr.GetInt32(i++));
        }

        #endregion
    }
}
