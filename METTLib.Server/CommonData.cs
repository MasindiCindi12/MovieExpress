using System;
using Singular.CommonData;

namespace MELib
{
  public class CommonData : CommonDataBase<MELib.CommonData.MECachedLists>
  {
        [Serializable]
        public class MECachedLists : CommonDataBase<MECachedLists>.CachedLists
        {
            /// <summary>
            /// Gets cached ROUserList
            /// </summary>
            public MELib.RO.ROUserList ROUserList
            {
                get
                {
                    return RegisterList<MELib.RO.ROUserList>(Misc.ContextType.Application, c => c.ROUserList, () => { return MELib.RO.ROUserList.GetROUserList(); });
                }
            }
            /// <summary>
            /// Gets cached ROMovieGenreList
            /// </summary>
            public RO.ROMovieGenreList ROMovieGenreList
            {
                get
                {
                    return RegisterList<MELib.RO.ROMovieGenreList>(Misc.ContextType.Application, c => c.ROMovieGenreList, () => { return MELib.RO.ROMovieGenreList.GetROMovieGenreList(); });
                }
            }

            public RO.ROProductCategoryList ROProductCategoryList
            {
                get
                {
                    return RegisterList<MELib.RO.ROProductCategoryList>(Misc.ContextType.Application, c => c.ROProductCategoryList, () => { return MELib.RO.ROProductCategoryList.GetROProductCategoryList(); });
                }
            }

            public Categories.CategoryList CategoryList
            {
                get
                {
                    return RegisterList<MELib.Categories.CategoryList>(Misc.ContextType.Application, c => c.CategoryList, () => { return MELib.Categories.CategoryList.GetCategoryList(); });
                }
            }


            public Shipment.ShipmentMethodList ShipmentMethodList
            {
                get
                {
                    return RegisterList<MELib.Shipment.ShipmentMethodList>(Misc.ContextType.Application, c => c.ShipmentMethodList, () => { return MELib.Shipment.ShipmentMethodList.GetShipmentMethodList(); });
                }
            }

            //public RO.ROUserList ROUserList
            //{
            //    get
            //    {
            //        return RegisterList<MELib.RO.ROUserList>(Misc.ContextType.Application, c => c.ROUserList, () => { return MELib.RO.ROUserList.GetROUserList(); });
            //    }
            //}

        }
    }

  public class Enums
  {
		public enum AuditedInd
		{
			Yes = 1,
			No = 0
		}
    public enum DeletedInd
    {
      Yes = 1,
      No = 0
    }
  }
}
