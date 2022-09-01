import 'package:moviez/models/movie_details_model.dart';
import 'package:moviez/services/network.dart';
import 'package:moviez/utilities/api_keys.dart';

class MovieGenreModel {
  Future<List<MovieModel>> getMoviesByGenre(String genre) async {
    NetworkHelper helper = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/byGen/$genre/",
        query: {"page_size": "26", "page": "1"},
        headers: kHeaders);

    var data = await helper.getData();
    // get a list of {"imdb_id" = x , "title" = y} for the specific genre
    List results = data["results"];

    print(results.toString());

    List<MovieModel> moviesByGenre = [];
    // we search for "id" in all the list items and use it to send requests and create MovieModels

    for (var obj in results) {
      NetworkHelper n = NetworkHelper(
          hostName: X_RapidAPI_Host,
          apiPath: "/movie/id/${obj["imdb_id"]}/",
          headers: kHeaders);

      var fullMovieDataJson = await n.getData();
      MovieModel m = MovieModel.fromJson(fullMovieDataJson);
      print(m.toString());
      moviesByGenre.add(m);
    }

    print(moviesByGenre.toString());
    return moviesByGenre;
  }
}
