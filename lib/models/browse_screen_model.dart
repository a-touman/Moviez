import 'dart:math';
import 'movie_poster.dart';
import 'package:moviez/models/movie_details_model.dart';
import 'package:moviez/services/network.dart';
import 'package:moviez/utilities/api_keys.dart';

class MovieBrowseModel {
  MovieBrowseModel();

  Future<MovieModel> getPickOfTheDay() async {
    // get a random year from 1970 -> 2021
    int year = Random().nextInt(2021 - 1970) + 1970;

    NetworkHelper helper = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/byYear/$year/",
        query: {"page_size": "10", "page": "1"},
        headers: kHeaders);

    var data = await helper.getData();

    // get a random movie out of results
    var randomMovie = data["results"][Random().nextInt(10)];

    // get the full data of the movie
    NetworkHelper n = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/id/${randomMovie["imdb_id"]}/",
        headers: kHeaders);
    var fullRandomMovieJson = await n.getData();
    MovieModel m = MovieModel.fromJson(fullRandomMovieJson);

    return m;
  }

  Future<List<MoviePoster>> getPopularMoviesList() async {
    List<MoviePoster> popularMovies = [];

    NetworkHelper helper = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/order/byPopularity/",
        query: {"page_size": "10", "page": "1"},
        headers: kHeaders);

    var data = await helper.getData();
    var results = data["results"];

    for (var result in results) {
      NetworkHelper n = NetworkHelper(
          hostName: X_RapidAPI_Host,
          apiPath: "/movie/id/${result["imdb_id"]}/",
          headers: kHeaders);

      var fullJson = await n.getData();

      MoviePoster poster =
          MoviePoster(fullJson["results"]["banner"], result["imdb_id"]);

      popularMovies.add(poster);
    }

    return popularMovies;
  }

  Future<List<MoviePoster>> getTopRatedMoviesList() async {
    List<MoviePoster> topMovies = [];

    NetworkHelper helper = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/order/byRating/",
        query: {"page_size": "10", "page": "1"},
        headers: kHeaders);

    var data = await helper.getData();
    var results = data["results"];

    for (var result in results) {
      NetworkHelper n = NetworkHelper(
          hostName: X_RapidAPI_Host,
          apiPath: "/movie/id/${result["imdb_id"]}/",
          headers: kHeaders);

      var fullJson = await n.getData();

      MoviePoster poster =
          MoviePoster(fullJson["results"]["banner"], result["imdb_id"]);

      topMovies.add(poster);
    }

    return topMovies;
  }

  Future<List<MoviePoster>> getRecentMoviesList() async {
    List<MoviePoster> recentMovies = [];

    NetworkHelper helper = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/byYear/2021/",
        query: {"page_size": "10", "page": "1"},
        headers: kHeaders);

    var data = await helper.getData();
    var results = data["results"];

    for (var result in results) {
      NetworkHelper n = NetworkHelper(
          hostName: X_RapidAPI_Host,
          apiPath: "/movie/id/${result["imdb_id"]}/",
          headers: kHeaders);

      var fullJson = await n.getData();

      MoviePoster poster =
          MoviePoster(fullJson["results"]["banner"], result["imdb_id"]);

      recentMovies.add(poster);
    }

    return recentMovies;
  }
}
