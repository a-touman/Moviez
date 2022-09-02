import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:moviez/components/stars_rating.dart';
import 'package:moviez/models/browse_screen_model.dart';
import 'package:moviez/models/movie_details_model.dart';
import 'package:moviez/screens/movie_details_screen.dart';
import 'package:moviez/utilities/constants.dart';
import '../models/movie_poster.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  late Future<MovieModel> pickToday;
  late Future<List<MoviePoster>> popular;
  late Future<List<MoviePoster>> topRated;
  late Future<List<MoviePoster>> recentMovies;
  @override
  void initState() {
    super.initState();
    MovieBrowseModel model = MovieBrowseModel();
    pickToday = model.getPickOfTheDay();
    popular = model.getPopularMoviesList();
    topRated = model.getTopRatedMoviesList();
    recentMovies = model.getRecentMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PickOfTheDay(pickToday: pickToday),
              BrowsePageHeaders(heading: "Popular"),
              MovieSlider(movieList: popular),
              BrowsePageHeaders(heading: "Top Rated"),
              MovieSlider(movieList: topRated),
              BrowsePageHeaders(heading: "Recent"),
              MovieSlider(movieList: recentMovies),
            ],
          ),
        ),
      ),
    );
  }
}

class BrowsePageHeaders extends StatelessWidget {
  BrowsePageHeaders({
    required this.heading,
  });

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Not Implemented Yet",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            child: Text(
              "See All",
              style: TextStyle(fontSize: 12, color: Color(0xFF64959F)),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieSlider extends StatelessWidget {
  const MovieSlider({Key? key, required this.movieList}) : super(key: key);

  final Future<List<MoviePoster>> movieList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: movieList,
        builder: (context, AsyncSnapshot<List<MoviePoster>> snapshot) =>
            snapshot.hasData
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 10,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetails(
                                            movieId:
                                                snapshot.data![index].movieID),
                                      ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.network(
                                      // case image url failed
                                      "https://source.unsplash.com/random?sig=3",
                                      fit: BoxFit.fill,
                                    ),
                                    snapshot.data![index].movieBanner,
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                  ),
                                ),
                              ));
                        }),
                  )
                : MovieSliderSkeleton());
  }
}

class MovieSliderSkeleton extends StatelessWidget {
  const MovieSliderSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: 15,
          top: 10,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              highlightColor: kMainAppColor,
              baseColor: kWidgetBgColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: kWidgetBgColor,
                  width: MediaQuery.of(context).size.width * 0.33,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PickOfTheDay extends StatelessWidget {
  const PickOfTheDay({Key? key, required this.pickToday}) : super(key: key);
  final Future<MovieModel> pickToday;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Text(
            "Pick of the day 🎉",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
            future: pickToday,
            builder: (context, AsyncSnapshot<MovieModel> snapshot) => snapshot
                    .hasData
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetails(
                                  movieId: snapshot.data?.results.imdbId),
                            ));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.33,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data?.results.banner ??
                                "https://source.unsplash.com/random?sig=3"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                                  kMainAppColor.withOpacity(0.95),
                                  Colors.black.withOpacity(0.3)
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      snapshot.data?.results.title ?? "Movie",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          shadows: [
                                            Shadow(
                                                color: Colors.black,
                                                blurRadius: 10,
                                                offset: Offset(2, 2))
                                          ]),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      StarsRatingComponent(
                                          rating:
                                              snapshot.data?.results.rating),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${snapshot.data?.results.rating}",
                                        style:
                                            TextStyle(color: Color(0xFFFBCA78)),
                                      ),
                                      Text(
                                        "/10",
                                        style: kSubHeadingStyle,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  )
                : PickOfDaySkeleton()),
      ],
    );
  }
}

class PickOfDaySkeleton extends StatelessWidget {
  const PickOfDaySkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        highlightColor: kMainAppColor,
        baseColor: kWidgetBgColor,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.33,
          decoration: BoxDecoration(
              color: kWidgetBgColor, borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
