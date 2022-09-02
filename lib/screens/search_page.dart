import 'package:flutter/material.dart';
import 'package:moviez/components/search_field.dart';
import 'package:moviez/models/movie_details_model.dart';
import 'package:moviez/models/search_screen_model.dart';
import 'package:moviez/screens/movie_details_screen.dart';
import 'package:moviez/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  SearchPage({this.query = "Spider-man"});

  String query;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Search for a movie 🔍",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              SearchingWidgets(),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: FutureBuilder(
                    future: SearchModel.getSearchResultsList(widget.query),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MovieModel>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        case ConnectionState.done:
                          {
                            if (snapshot.data!.isNotEmpty) {
                              return SearchResults(
                                snapshot: snapshot,
                              );
                            } else {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "No results found for '${widget.query}'",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RaisedButton(
                                      onPressed: () async {
                                        var url =
                                            "https://www.google.com/search?q=${widget.query}";
                                        if (await canLaunch(url)) {
                                          await launch(url,
                                              forceWebView: true,
                                              enableJavaScript: true);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      color: kWidgetBgColor,
                                      child: const Text("Search Google"),
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                        default:
                          {
                            return Center(
                              child: Text("Error fetching data"),
                            );
                          }
                      } // end of switch
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SearchingWidgets() {
    String userInput = "";

    return Row(
      children: <Widget>[
        Expanded(
          child: SearchField(
            onChange: (value) {
              userInput = value.trim();
            },
            hint: " eg: Spider-man",
            withIcon: false,
            onSubmitted: (String value) {
              setState(() {
                if (value.isNotEmpty) {
                  widget.query = value.trim();
                }
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: InkWell(
            onTap: () {
              if (userInput.isNotEmpty) {
                setState(() {
                  widget.query = userInput;
                });
              }
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  color: kWidgetBgColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.search, color: kIconsColor),
            ),
          ),
        )
      ],
    );
  }

  Widget SearchResults({required AsyncSnapshot<List<MovieModel>> snapshot}) {
    return Container(
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetails(
                        movieId: snapshot.data![index].results.imdbId),
                  ));
            },
            visualDensity: VisualDensity(vertical: 4),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                snapshot.data![index].results.imageUrl ??
                    "https://source.unsplash.com/random?sig=3",
                width: 50,
                errorBuilder: (context, error, stackTrace) => Image.network(
                    // case image url failed
                    "https://source.unsplash.com/random?sig=3",
                    width: 50,
                    fit: BoxFit.fill),
              ),
            ),
            subtitle: Text("${snapshot.data![index].results.year}"),
            title: Text(
              snapshot.data![index].results.title ?? "No title",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
