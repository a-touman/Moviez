import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviez/components/movie_cat_card.dart';
import 'package:moviez/models/movie_genre_model.dart';
import 'package:moviez/screens/movie_details_screen.dart';
import 'package:moviez/utilities/constants.dart';
import '../components/movie_poster_component.dart';
import '../models/movie_details_model.dart';

class MovieGenrePage extends StatefulWidget {
  final String genre;

  MovieGenrePage({this.genre = "Drama"});

  @override
  State<MovieGenrePage> createState() => _MovieGenrePageState();
}

class _MovieGenrePageState extends State<MovieGenrePage> {
  late Future<List<MovieModel>> moviesbyGenre;

  @override
  void initState() {
    super.initState();
    moviesbyGenre = MovieGenreModel().getMoviesByGenre(widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
                "${widget.genre}  ${CategoryCard.getCategoryEmoji(widget.genre)}")),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.home_filled,
              color: kIconsColor,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: GenreSearchDelegate());
              },
              icon: Icon(
                Icons.search,
                color: kIconsColor,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: moviesbyGenre,
            builder: (context, AsyncSnapshot<List<MovieModel>> snapshot) {
              if (snapshot.hasData) {
                var movies = snapshot.data;
                return GridView.builder(
                  padding: EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      mainAxisSpacing: 30,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 20),
                  itemCount: movies?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var movie = movies![index];
                    return MoviePosterComponent(
                      title: movie.results.title,
                      imgURL: movie.results.imageUrl,
                      rating: movie.results.rating,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetails(
                                  movieId: movie.results
                                      .imdbId), // this can be greatly improved by pushing entire 'movie' object to MovieDetailsPage instead of making another request via the 'imdb_id'
                            ));
                      },
                    );
                  },
                );
              } else {
                return Center(
                    child: Lottie.asset("assets/loading.json",
                        height: 100, width: 100));
              }
            }),
      ),
    );
  }
}

class GenreSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
        appBarTheme: AppBarTheme(
            backgroundColor: kMainAppColor,
            elevation: 0,
            iconTheme: IconThemeData(color: kIconsColor)));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {}

  @override
  Widget? buildLeading(BuildContext context) {}

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
