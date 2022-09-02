import 'package:moviez/services/network.dart';
import 'package:moviez/utilities/api_keys.dart';

import 'movie_poster.dart';

class HomePageData {
  List<MoviePoster> _moviesList = [];

  // defines _idList with imdb_ids of movies to be used to get access to poster URLs later on
  Future<dynamic> _getResultsIDs() async {
    NetworkHelper helper = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/order/byRating/",
        query: {"page_size": "10", "page": "1"},
        headers: kHeaders);

    var data = await helper.getData();
    List resList = data["results"];
    var idList = resList.map((e) => e["imdb_id"]).toList();
    return idList;
  }

  // gives us a list of MoviePosters containing movie ids and their poster urls
  Future<List<MoviePoster>> getHomeScreenImages() async {
    List idList = await _getResultsIDs();

    for (String id in idList) {
      NetworkHelper helper = NetworkHelper(
          hostName: X_RapidAPI_Host,
          apiPath: "/movie/id/$id/",
          headers: kHeaders);

      var data = await helper.getData();
      var bannerURL = data["results"]["banner"];
      _moviesList.add(MoviePoster(bannerURL, id));
    }

    return _moviesList;
  }
}
