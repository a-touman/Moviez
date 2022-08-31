import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviez/components/ticket_button.dart';
import 'package:moviez/models/movie_details_model.dart';
import 'package:moviez/services/network.dart';
import 'package:moviez/utilities/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/stars_rating.dart';
import '../utilities/api_keys.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key, this.movieId = "tt10942302"}) : super(key: key);

  final String? movieId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<MovieModel> movieModel;

  @override
  void initState() {
    super.initState();
    movieModel = getApiData(widget.movieId);
  }

  Future<MovieModel> getApiData(String? movieID) async {
    NetworkHelper helper = NetworkHelper(
        hostName: X_RapidAPI_Host,
        apiPath: "/movie/id/$movieID/",
        headers: kHeaders);

    var json = await helper.getData();
    print(json["results"]["release"]);

    return MovieModel.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: movieModel,
          builder: (context, AsyncSnapshot<MovieModel> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data?.results.trailer);
              return BlurryBackground(
                imgURL: "${snapshot.data?.results.banner}",
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 25.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.3),
                                  child: Icon(Icons.arrow_back_ios_new_outlined,
                                      size: 17, color: Colors.white70),
                                ),
                              ),
                              Text(
                                "Movie Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.9),
                                      offset: Offset(2, 2),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "${snapshot.data?.results.banner}",
                                fit: BoxFit.fill,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "${snapshot.data?.results.title}", // Movie Name
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(),
                                Text(
                                  "${snapshot.data?.results.year}", // movie year
                                  style: TextStyle(color: kSubHeadingColor),
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.white70,
                                  size: 5,
                                ),
                                Text(
                                  "${snapshot.data?.results.gen![0].genre ?? "Genre"}", // movie genre
                                  style: TextStyle(color: kSubHeadingColor),
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.white70,
                                  size: 5,
                                ),
                                Text(
                                  "${snapshot.data?.results.movieLength} Mins", // movie time
                                  style: TextStyle(color: kSubHeadingColor),
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          StarsRatingComponent(
                              rating: snapshot.data?.results.rating),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${snapshot.data?.results.rating}",
                            style: TextStyle(
                                color: Color(0xFFFBCA78),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "${snapshot.data?.results.description}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kSubHeadingColor, fontSize: 16),
                            ),
                          ),
                          snapshot.data?.results.trailer != null
                              ? RaisedButton(
                                  onPressed: () async {
                                    var url = snapshot.data?.results.trailer;
                                    if (await canLaunch(url!)) {
                                      await launch(url,
                                          forceWebView: true,
                                          enableJavaScript: true);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  color: Colors.green,
                                  child: Text("Watch Trailer"),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Lottie.asset("assets/loading.json"),
              );
            }
          },
        ),
      ),
    );
  }
}

class BlurryBackground extends StatelessWidget {
  BlurryBackground({required this.child, required this.imgURL});

  final Widget child;
  final String imgURL;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kMainAppColor, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Image.network(
            imgURL,
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      kMainAppColor,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
                child: child,
              ),
            ),
          ),
        )
      ],
    );
  }
}
