﻿// Generated 03 Jul 2018 13:23 - Singular Systems Object Generator Version 2.2.694
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


namespace MELib.RO
{
	[Serializable]
	public class ROThreatSubCategory
	 : SingularReadOnlyBase<ROThreatSubCategory>
	{
		#region " Properties and Methods "

		#region " Properties "

		public static PropertyInfo<int> ThreatSubCategoryIDProperty = RegisterProperty<int>(c => c.ThreatSubCategoryID, "ID", 0);
		/// <summary>
		/// Gets the ID value
		/// </summary>
		[Display(AutoGenerateField = false), Key]
		public int ThreatSubCategoryID
		{
			get { return GetProperty(ThreatSubCategoryIDProperty); }
		}

		public static PropertyInfo<int?> ThreatCategoryIDProperty = RegisterProperty<int?>(c => c.ThreatCategoryID, "Threat Category", null);
		/// <summary>
		/// Gets the Threat Category value
		/// </summary>
		[Display(Name = "Threat Category", Description = "Threat Category ID")]
		public int? ThreatCategoryID
		{
			get { return GetProperty(ThreatCategoryIDProperty); }
		}

		public static PropertyInfo<String> ThreatSubCategoryNameProperty = RegisterProperty<String>(c => c.ThreatSubCategoryName, "Threat Sub Category Name", "");
		/// <summary>
		/// Gets the Threat Sub Category Name value
		/// </summary>
		[Display(Name = "Threat Sub Category Name", Description = "Name of Threat Sub Category ")]
		public String ThreatSubCategoryName
		{
			get { return GetProperty(ThreatSubCategoryNameProperty); }
		}

		public static PropertyInfo<String> ThreatSubCategoryDescriptionProperty = RegisterProperty<String>(c => c.ThreatSubCategoryDescription, "Threat Sub Category Description", "");
		/// <summary>
		/// Gets the Threat Sub Category Description value
		/// </summary>
		[Display(Name = "Threat Sub Category Description", Description = "Additional Threat Description")]
		public String ThreatSubCategoryDescription
		{
			get { return GetProperty(ThreatSubCategoryDescriptionProperty); }
		}

		public static PropertyInfo<Boolean> IsActiveIndProperty = RegisterProperty<Boolean>(c => c.IsActiveInd, "Is Active", true);
		/// <summary>
		/// Gets the Is Active value
		/// </summary>
		[Display(Name = "Is Active", Description = "")]
		public Boolean IsActiveInd
		{
			get { return GetProperty(IsActiveIndProperty); }
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

		public static PropertyInfo<SmartDate> CreatedDateTimeProperty = RegisterProperty<SmartDate>(c => c.CreatedDateTime, "Created Date Time", new SmartDate(DateTime.Now));
		/// <summary>
		/// Gets the Created Date Time value
		/// </summary>
		[Display(AutoGenerateField = false)]
		public SmartDate CreatedDateTime
		{
			get { return GetProperty(CreatedDateTimeProperty); }
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

		public static PropertyInfo<SmartDate> ModifiedDateTimeProperty = RegisterProperty<SmartDate>(c => c.ModifiedDateTime, "Modified Date Time", new SmartDate(DateTime.Now));
		/// <summary>
		/// Gets the Modified Date Time value
		/// </summary>
		[Display(AutoGenerateField = false)]
		public SmartDate ModifiedDateTime
		{
			get { return GetProperty(ModifiedDateTimeProperty); }
		}

		#endregion

		#region " Methods "

		protected override object GetIdValue()
		{
			return GetProperty(ThreatSubCategoryIDProperty);
		}

		public override string ToString()
		{
			return this.ThreatSubCategoryName;
		}

		#endregion

		#endregion

		#region " Data Access & Factory Methods "

		internal static ROThreatSubCategory GetROThreatSubCategory(SafeDataReader dr)
		{
			var r = new ROThreatSubCategory();
			r.Fetch(dr);
			return r;
		}

		protected void Fetch(SafeDataReader sdr)
		{
			int i = 0;
			LoadProperty(ThreatSubCategoryIDProperty, sdr.GetInt32(i++));
			LoadProperty(ThreatCategoryIDProperty, Singular.Misc.ZeroNothing(sdr.GetInt32(i++)));
			LoadProperty(ThreatSubCategoryNameProperty, sdr.GetString(i++));
			LoadProperty(ThreatSubCategoryDescriptionProperty, sdr.GetString(i++));
			LoadProperty(IsActiveIndProperty, sdr.GetBoolean(i++));
			LoadProperty(CreatedByProperty, sdr.GetInt32(i++));
			LoadProperty(CreatedDateTimeProperty, sdr.GetSmartDate(i++));
			LoadProperty(ModifiedByProperty, sdr.GetInt32(i++));
			LoadProperty(ModifiedDateTimeProperty, sdr.GetSmartDate(i++));
		}

		#endregion

	}

}