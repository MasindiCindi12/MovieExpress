<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditableTable.aspx.cs" Inherits="MEWeb.Examples.EditableTable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  <script type="text/javascript" src="../Scripts/JSLINQ.js"></script>
  <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
  <%
      using (var h = this.Helpers)
      {

          var MainHDiv = h.DivC("row pad-top-10");
          {
              var PanelContainer = MainHDiv.Helpers.DivC("col-md-12 p-n-lr");
              {
                  var HomeContainer = PanelContainer.Helpers.DivC("tabs-container");
                  {
                      var AssessmentsTab = HomeContainer.Helpers.TabControl();
                      {
                          AssessmentsTab.Style.ClearBoth();
                          AssessmentsTab.AddClass("nav nav-tabs");
                          var HomeContainerTab = AssessmentsTab.AddTab("Movies");
                          {
                              var Row = HomeContainerTab.Helpers.DivC("row margin0");
                              {
                                  var RowCol = Row.Helpers.DivC("col-md-12");
                                  {
                                      RowCol.Helpers.HTML().Heading2("Movies Management");
                                      RowCol.Helpers.HTMLTag("br/");


                                      var MovieList = RowCol.Helpers.TableFor<MELib.Movies.Movie>((c) => c.MovieList, true, true);
                                      {
                                          MovieList.AddClass("table table-striped table-bordered table-hover");
                                          var MovieListRow = MovieList.FirstRow;
                                          {
                                              var MovieTitle = MovieListRow.AddColumn(c => c.MovieTitle);
                                              {
                                                  MovieTitle.Style.Width = "600px";
                                              }
                                              var MovieGenreID = MovieListRow.AddColumn(c => c.MovieGenreID);
                                              {
                                                  MovieGenreID.Style.Width = "200px";
                                              }
                                              var MovieURL = MovieListRow.AddColumn(c => c.MovieImageURL);
                                              {
                                                  MovieURL.Style.Width = "200px";
                                              }
                                              var MovieDescription = MovieListRow.AddColumn(c => c.MovieDescription);
                                              var MovieReleaseDate = MovieListRow.AddColumn(c => c.ReleaseDate);
                                              {
                                                  MovieReleaseDate.Style.Width = "175px";
                                              }
                                              var MovieAvailable = MovieListRow.AddColumn(c => c.IsActiveInd);
                                          }
                                      }

                                      var SaveList = RowCol.Helpers.DivC("col-md-12 text-right");
                                      {
                                          var SaveBtn = SaveList.Helpers.Button("Save", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                          {
                                              SaveBtn.AddClass("btn-primary btn btn btn-primary");
                                              SaveBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "SaveMovies($data)");
                                          }
                                      }

                                  }
                              }
                             
                          }
                      }
                  }
              }
          }
      }
  %>

  <script type="text/javascript">
    Singular.OnPageLoad(function () {
      $("#menuItem5").addClass("active");
      $("#menuItem5 > ul").addClass("in");
    });

    var SaveMovies = function (obj) {
      ViewModel.CallServerMethod('SaveMovieList', { MovieList: ViewModel.MovieList.Serialise(), ShowLoadingBar: true }, function (result) {
          if (result.Success) {
              window.location = result.Data;
              Singular.ShowMessage('Save', 'Successfully Saved', 90000000000000000000000000000000);
              MEHelpers.Notification("Successfully Saved", 'center', 'success', 30000000000000000000000000000);
              window.location = result.Data;
              location.reload();
        }
        else {
          MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
        }
      });
    }

  </script>
</asp:Content>
