﻿// Generated 11 Nov 2021 14:14 - Singular Systems Object Generator Version 2.2.694
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
    public class ShipmentMethodList
     : SingularBusinessListBase<ShipmentMethodList, ShipmentMethod>
    {
        #region " Business Methods "

        public ShipmentMethod GetItem(int ShipmentMethodID)
        {
            foreach (ShipmentMethod child in this)
            {
                if (child.ShipmentMethodID == ShipmentMethodID)
                {
                    return child;
                }
            }
            return null;
        }

        public override string ToString()
        {
            return "Shipment Methods";
        }

        #endregion

        #region " Data Access "

        [Serializable]
        public class Criteria : CriteriaBase<Criteria>
        {

           public  int? ShipmentMethodID = null;
            public Criteria()
            {
            }

            public Criteria(int? ShipmentID)
            {

                this.ShipmentMethodID = ShipmentID;
            }

        }

        public static ShipmentMethodList NewShipmentMethodList()
        {
            return new ShipmentMethodList();
        }

        public ShipmentMethodList()
        {
            // must have parameter-less constructor
        }

        public static ShipmentMethodList GetShipmentMethodList()
        {
            return DataPortal.Fetch<ShipmentMethodList>(new Criteria());
        }


        public static ShipmentMethodList GetShipmentMethodList(int? ShipmentMethodID)
        {
            return DataPortal.Fetch<ShipmentMethodList>(new Criteria(ShipmentMethodID= ShipmentMethodID));
        }
//come here
        protected void Fetch(SafeDataReader sdr)
        {
            this.RaiseListChangedEvents = false;
            while (sdr.Read())
            {
                this.Add(ShipmentMethod.GetShipmentMethod(sdr));
            }
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
                        cm.CommandText = "GetProcs.getShipmentMethodList";
                        cm.Parameters.AddWithValue("@ShipmentMethodID", Singular.Misc.NothingDBNull(crit.ShipmentMethodID));
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