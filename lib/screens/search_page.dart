import 'package:flutter/material.dart';
import 'package:moviez/components/search_field.dart';
import 'package:moviez/models/movie_details_model.dart';
import 'package:moviez/models/search_screen_model.dart';
import 'package:moviez/utilities/constants.dart';

late Future<List<MovieModel>> searchResultList;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();

    searchResultList = SearchModel.getSearchResultsList("Movie");
  }

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
                    future: searchResultList,
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
                                child: Text("No Results found"),
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
}

class SearchResults extends StatelessWidget {
  SearchResults({required this.snapshot});

  final AsyncSnapshot<List<MovieModel>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ListTile(
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

class SearchingWidgets extends StatelessWidget {
  const SearchingWidgets({
    Key? key,
  }) : super(key: key);

  static String query = "";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SearchField(
              onChange: (value) {
                query = value.trim();
              },
              hint: " ",
              withIcon: false),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: InkWell(
            onTap: () {
              if (query.isNotEmpty) {
                searchResultList = SearchModel.getSearchResultsList(query);
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
}
