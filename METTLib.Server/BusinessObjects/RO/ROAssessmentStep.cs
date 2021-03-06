// Generated 23 Jul 2018 01:44 - Singular Systems Object Generator Version 2.2.693
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


namespace METTLib.RO
{
	[Serializable]
	public class ROAssessmentStep
	 : METTReadOnlyBase<ROAssessmentStep>
	{
		#region " Properties and Methods "

		#region " Properties "

		public static PropertyInfo<int> AssessmentStepIDProperty = RegisterProperty<int>(c => c.AssessmentStepID, "ID", 0);
		/// <summary>
		/// Gets the ID value
		/// </summary>
		[Display(AutoGenerateField = false), Key, DisplayName("ID")]
		public int AssessmentStepID
		{
			get { return GetProperty(AssessmentStepIDProperty); }
		}

		public static PropertyInfo<String> AssessmentStepProperty = RegisterProperty<String>(c => c.AssessmentStep, "Assessmentstep", "");
		/// <summary>
		/// Gets the Assessmentstep value
		/// </summary>
		[Display(Name = "Assessmentstep", Description = "Current  State of Assesment : In Progress, Complete, Audit"), DisplayName("Assessmentstep")]
		public String AssessmentStep
		{
			get { return GetProperty(AssessmentStepProperty); }
		}

		public static PropertyInfo<int> AssesssmentStepNoProperty = RegisterProperty<int>(c => c.AssesssmentStepNo, "Assesssmentstepno", 0);
		/// <summary>
		/// Gets the Assesssmentstepno value
		/// </summary>
		[Display(Name = "Assesssmentstepno", Description = ""), DisplayName("Assesssmentstepno")]
		public int AssesssmentStepNo
		{
			get { return GetProperty(AssesssmentStepNoProperty); }
		}

		public static PropertyInfo<Boolean> IsActiveIndProperty = RegisterProperty<Boolean>(c => c.IsActiveInd, "Isactiveind", true);
		/// <summary>
		/// Gets the Isactiveind value
		/// </summary>
		[Display(Name = "Isactiveind", Description = "Indicates whether question is currently active"), DisplayName("Isactiveind")]
		public Boolean IsActiveInd
		{
			get { return GetProperty(IsActiveIndProperty); }
		}

		public static PropertyInfo<int> CreatedByProperty = RegisterProperty<int>(c => c.CreatedBy, "Createdby", 0);
		/// <summary>
		/// Gets the Createdby value
		/// </summary>
		[Display(AutoGenerateField = false), DisplayName("Createdby")]
		public int? CreatedBy
		{
			get { return GetProperty(CreatedByProperty); }
		}

		public static PropertyInfo<SmartDate> CreatedDateTimeProperty = RegisterProperty<SmartDate>(c => c.CreatedDateTime, "Createddatetime", new SmartDate(DateTime.Now));
		/// <summary>
		/// Gets the Createddatetime value
		/// </summary>
		[Display(AutoGenerateField = false), DisplayName("Createddatetime")]
		public SmartDate CreatedDateTime
		{
			get { return GetProperty(CreatedDateTimeProperty); }
		}

		public static PropertyInfo<int> ModifiedByProperty = RegisterProperty<int>(c => c.ModifiedBy, "Modifiedby", 0);
		/// <summary>
		/// Gets the Modifiedby value
		/// </summary>
		[Display(AutoGenerateField = false), DisplayName("Modifiedby")]
		public int? ModifiedBy
		{
			get { return GetProperty(ModifiedByProperty); }
		}

		public static PropertyInfo<SmartDate> ModifiedDateTimeProperty = RegisterProperty<SmartDate>(c => c.ModifiedDateTime, "Modifieddatetime", new SmartDate(DateTime.Now));
		/// <summary>
		/// Gets the Modifieddatetime value
		/// </summary>
		[Display(AutoGenerateField = false), DisplayName("Modifieddatetime")]
		public SmartDate ModifiedDateTime
		{
			get { return GetProperty(ModifiedDateTimeProperty); }
		}

		#endregion

		#region " Methods "

		protected override object GetIdValue()
		{
			return GetProperty(AssessmentStepIDProperty);
		}

		public override string ToString()
		{
			return this.AssessmentStep;
		}

		#endregion

		#endregion

		#region " Data Access & Factory Methods "

		internal static ROAssessmentStep GetROAssessmentStep(SafeDataReader dr)
		{
			var r = new ROAssessmentStep();
			r.Fetch(dr);
			return r;
		}

		protected void Fetch(SafeDataReader sdr)
		{
			int i = 0;
			LoadProperty(AssessmentStepIDProperty, sdr.GetInt32(i++));
			LoadProperty(AssessmentStepProperty, sdr.GetString(i++));
			LoadProperty(AssesssmentStepNoProperty, sdr.GetInt32(i++));
			LoadProperty(IsActiveIndProperty, sdr.GetBoolean(i++));
			LoadProperty(CreatedByProperty, sdr.GetInt32(i++));
			LoadProperty(CreatedDateTimeProperty, sdr.GetSmartDate(i++));
			LoadProperty(ModifiedByProperty, sdr.GetInt32(i++));
			LoadProperty(ModifiedDateTimeProperty, sdr.GetSmartDate(i++));
		}

		#endregion

	}

}