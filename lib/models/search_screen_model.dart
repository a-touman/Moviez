import 'package:moviez/models/movie_details_model.dart';

import '../services/network.dart';
import '../utilities/api_keys.dart';

class SearchModel {
  static Future<List<MovieModel>> getSearchResultsList(String query) async {
    NetworkHelper helper = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/imdb_id/byTitle/$query/",
        headers: kHeaders);

    var data = await helper.getData();
    // get a list of {"imdb_id" = x , "title" = y} for the specific query
    List results = data["results"];

    print(results.toString());

    List<MovieModel> moviesBySearch = [];
    // we search for "id" in all the list items and use it to send requests and create MovieModels

    for (var obj in results) {
      NetworkHelper n = NetworkHelper(
          hostName: X_RapidAPI_Host,
          apiPath: "/movie/id/${obj["imdb_id"]}/",
          headers: kHeaders);

      var fullMovieDataJson = await n.getData();
      MovieModel m = MovieModel.fromJson(fullMovieDataJson);
      print(m.toString());
      moviesBySearch.add(m);
    }

    print(moviesBySearch.toString());
    return moviesBySearch;
  }
}
