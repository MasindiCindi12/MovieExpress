namespace MEWeb.Examples
{

    public partial class MultiSelect : MEPageBase<MultiSelectVM>
  {

  }
  public class MultiSelectVM : MEStatelessViewModel<MultiSelectVM>
  {
    public MELib.Movies.MovieList MovieList { get; set; }

    public MultiSelectVM()
    {
    }
    protected override void Setup()
    {
      base.Setup();
      MovieList = MELib.Movies.MovieList.GetMovieList();
    }

 

    
  }

}


