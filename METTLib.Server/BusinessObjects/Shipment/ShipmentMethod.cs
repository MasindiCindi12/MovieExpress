// Generated 11 Nov 2021 14:14 - Singular Systems Object Generator Version 2.2.694
//<auto-generated/>
using System;
using Csla;
using Csla.Serialization;
using Csla.Data;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using Singular;
using System.Data;
using System.Data.SqlClient;


namespace MELib.Shipment
{
    [Serializable]
    public class ShipmentMethod
     : SingularBusinessBase<ShipmentMethod>
    {
        #region " Properties and Methods "

        #region " Properties "

        public static PropertyInfo<int> ShipmentMethodIDProperty = RegisterProperty<int>(c => c.ShipmentMethodID, "ID", 0);
        /// <summary>
        /// Gets the ID value
        /// </summary>
        [Display(AutoGenerateField = false), Key]
        public int ShipmentMethodID
        {
            get { return GetProperty(ShipmentMethodIDProperty); }
        }

        public static PropertyInfo<String> ShipmentMethodNameProperty = RegisterProperty<String>(c => c.ShipmentMethodName, "Shipment Method Name", "");
        /// <summary>
        /// Gets and sets the Shipment Method Name value
        /// </summary>
        [Display(Name = "Shipment Method Name", Description = ""),
        StringLength(250, ErrorMessage = "Shipment Method Name cannot be more than 250 characters")]
        public String ShipmentMethodName
        {
            get { return GetProperty(ShipmentMethodNameProperty); }
            set { SetProperty(ShipmentMethodNameProperty, value); }
        }

        public static PropertyInfo<String> ShipmentMethodDescriptionProperty = RegisterProperty<String>(c => c.ShipmentMethodDescription, "Shipment Method Description", "");
        /// <summary>
        /// Gets and sets the Shipment Method Description value
        /// </summary>
        [Display(Name = "Shipment Method Description", Description = ""),
        StringLength(250, ErrorMessage = "Shipment Method Description cannot be more than 250 characters")]
        public String ShipmentMethodDescription
        {
            get { return GetProperty(ShipmentMethodDescriptionProperty); }
            set { SetProperty(ShipmentMethodDescriptionProperty, value); }
        }

        public static PropertyInfo<Decimal> PriceProperty = RegisterProperty<Decimal>(c => c.Price, "Price", 0D);
        /// <summary>
        /// Gets and sets the Price value
        /// </summary>
        [Display(Name = "Price", Description = "")]
        public Decimal Price
        {
            get { return GetProperty(PriceProperty); }
            set { SetProperty(PriceProperty, value); }
        }

        public static PropertyInfo<int> IsActiveIndProperty = RegisterProperty<int>(c => c.IsActiveInd, "Is Active", 0);
        /// <summary>
        /// Gets and sets the Is Active value
        /// </summary>
        [Display(Name = "Is Active", Description = "")]
        public int IsActiveInd
        {
            get { return GetProperty(IsActiveIndProperty); }
            set { SetProperty(IsActiveIndProperty, value); }
        }

        public static PropertyInfo<DateTime?> DeletedDateProperty = RegisterProperty<DateTime?>(c => c.DeletedDate, "Deleted Date");
        /// <summary>
        /// Gets and sets the Deleted Date value
        /// </summary>
        [Display(Name = "Deleted Date", Description = "")]
        public DateTime? DeletedDate
        {
            get
            {
                return GetProperty(DeletedDateProperty);
            }
            set
            {
                SetProperty(DeletedDateProperty, value);
            }
        }

        public static PropertyInfo<int> DeletedByProperty = RegisterProperty<int>(c => c.DeletedBy, "Deleted By", 0);
        /// <summary>
        /// Gets and sets the Deleted By value
        /// </summary>
        [Display(Name = "Deleted By", Description = "")]
        public int DeletedBy
        {
            get { return GetProperty(DeletedByProperty); }
            set { SetProperty(DeletedByProperty, value); }
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
            return GetProperty(ShipmentMethodIDProperty);
        }

        public override string ToString()
        {
            if (this.ShipmentMethodName.Length == 0)
            {
                if (this.IsNew)
                {
                    return String.Format("New {0}", "Shipment Method");
                }
                else
                {
                    return String.Format("Blank {0}", "Shipment Method");
                }
            }
            else
            {
                return this.ShipmentMethodName;
            }
        }

        #endregion

        #endregion

        #region " Validation Rules "

        protected override void AddBusinessRules()
        {
            base.AddBusinessRules();
        }

        #endregion

        #region " Data Access & Factory Methods "

        protected override void OnCreate()
        {
            // This is called when a new object is created
            // Set any variables here, not in the constructor or NewShipmentMethod() method.
        }

        public static ShipmentMethod NewShipmentMethod()
        {
            return DataPortal.CreateChild<ShipmentMethod>();
        }

        public ShipmentMethod()
        {
            MarkAsChild();
        }

        internal static ShipmentMethod GetShipmentMethod(SafeDataReader dr)
        {
            var s = new ShipmentMethod();
            s.Fetch(dr);
            return s;
        }

        protected void Fetch(SafeDataReader sdr)
        {
            using (BypassPropertyChecks)
            {
                int i = 0;
                LoadProperty(ShipmentMethodIDProperty, sdr.GetInt32(i++));
                LoadProperty(ShipmentMethodNameProperty, sdr.GetString(i++));
                LoadProperty(ShipmentMethodDescriptionProperty, sdr.GetString(i++));
                LoadProperty(PriceProperty, sdr.GetDecimal(i++));
                LoadProperty(IsActiveIndProperty, sdr.GetInt32(i++));
                LoadProperty(DeletedDateProperty, sdr.GetValue(i++));
                LoadProperty(DeletedByProperty, sdr.GetInt32(i++));
                LoadProperty(CreatedDateProperty, sdr.GetSmartDate(i++));
                LoadProperty(CreatedByProperty, sdr.GetInt32(i++));
                LoadProperty(ModifiedDateProperty, sdr.GetSmartDate(i++));
                LoadProperty(ModifiedByProperty, sdr.GetInt32(i++));
            }

            MarkAsChild();
            MarkOld();
            BusinessRules.CheckRules();
        }

        protected override Action<SqlCommand> SetupSaveCommand(SqlCommand cm)
        {
            LoadProperty(ModifiedByProperty, Settings.CurrentUser.UserID);

            AddPrimaryKeyParam(cm, ShipmentMethodIDProperty);

            cm.Parameters.AddWithValue("@ShipmentMethodName", GetProperty(ShipmentMethodNameProperty));
            cm.Parameters.AddWithValue("@ShipmentMethodDescription", GetProperty(ShipmentMethodDescriptionProperty));
            cm.Parameters.AddWithValue("@Price", GetProperty(PriceProperty));
            cm.Parameters.AddWithValue("@IsActiveInd", GetProperty(IsActiveIndProperty));
            cm.Parameters.AddWithValue("@DeletedDate", Singular.Misc.NothingDBNull(DeletedDate));
            cm.Parameters.AddWithValue("@DeletedBy", GetProperty(DeletedByProperty));
            cm.Parameters.AddWithValue("@ModifiedBy", GetProperty(ModifiedByProperty));

            return (scm) =>
            {
    // Post Save
    if (this.IsNew)
                {
                    LoadProperty(ShipmentMethodIDProperty, scm.Parameters["@ShipmentMethodID"].Value);
                }
            };
        }

        protected override void SaveChildren()
        {
            // No Children
        }

        protected override void SetupDeleteCommand(SqlCommand cm)
        {
            cm.Parameters.AddWithValue("@ShipmentMethodID", GetProperty(ShipmentMethodIDProperty));
        }

        #endregion

    }

}