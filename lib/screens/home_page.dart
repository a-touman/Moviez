import 'package:flutter/material.dart';
import 'package:moviez/models/home_screen_model.dart';
import 'package:moviez/screens/movie_details_screen.dart';
import 'package:moviez/screens/search_page.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:moviez/utilities/constants.dart';
import 'package:moviez/components/search_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_deck/swipe_deck.dart';
import '../components/movie_cat_card.dart';
import 'package:lottie/lottie.dart';

import '../models/movie_poster.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MoviePoster> _MOVIES = [];
  bool _isLoading = true;

  Future<void> getMovies() async {
    _MOVIES = await HomePageData().getHomeScreenImages();
    setState(() {
      _isLoading = false;
    });

    print(_MOVIES);
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TopScreenWelcome(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: SearchField(
                    onSubmitted: (value) {
                      if (value.isNotEmpty)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(query: value),
                            ));
                    },
                    onChange: (value) {},
                    hint: "Search movie",
                    withIcon: true),
              ),
              SizedBox(
                height: 15,
              ),
              MovieCategories(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryCard("Horror"),
                      CategoryCard("Comedy"),
                      CategoryCard("Romance"),
                      CategoryCard("Drama"),
                      CategoryCard("Sci-Fi"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              _isLoading
                  ? Lottie.asset("assets/loading.json", height: 100, width: 100)
                  : SwipeMoviesSection(
                      movieList: _MOVIES,
                    ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwipeMoviesSection extends StatelessWidget {
  SwipeMoviesSection({required this.movieList});

  List<MoviePoster> movieList;
  @override
  Widget build(BuildContext context) {
    return SwipeDeck(
      aspectRatio: 100 / 70,
      startIndex: 2,
      emptyIndicator: Center(child: Text("No Movie Data")),
      cardSpreadInDegrees: 10,
      widgets: movieList
          .map((e) => GestureDetector(
                onTap: () async {
                  print(e.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(movieId: e.movieID),
                      ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    e.movieBanner,
                    fit: BoxFit.cover,
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class MovieCategories extends StatelessWidget {
  const MovieCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Movie Categories",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              //TODO: Implement all movie categories section
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
          )
        ],
      ),
    );
  }
}

class TopScreenWelcome extends StatefulWidget {
  @override
  State<TopScreenWelcome> createState() => _TopScreenWelcomeState();
}

class _TopScreenWelcomeState extends State<TopScreenWelcome> {
  @override
  Widget build(BuildContext context) {
    // String lName = Provider.of<LoginProvider>(context).lName;
    // String lSeed = Provider.of<LoginProvider>(context).lSeed;

    Future<String> getName() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String name = prefs.getString("name") ?? " ";
      print(name);
      return name;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: FutureBuilder(
        future: getName(),
        builder: (context, snapshot) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Hello ${snapshot.data.toString()} 👋 ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text("Browse your favourite movies", style: kSubHeadingStyle),
            ]),
            randomAvatar(
              "${snapshot.data.toString()}",
              height: 50,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}
