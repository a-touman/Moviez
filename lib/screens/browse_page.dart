import 'package:flutter/material.dart';
import 'package:moviez/components/stars_rating.dart';
import 'package:moviez/utilities/constants.dart';

import '../components/movie_cat_card.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({Key? key}) : super(key: key);

  static const test = [
    "fight_club",
    "godfather",
    "maze_runner",
    "ouatih",
    "venom"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PickOfTheDay(),
            Container(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Text(
                "Popular",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
          ],
        ),
      ),
    );
  }
}

class PickOfTheDay extends StatelessWidget {
  const PickOfTheDay({Key? key}) : super(key: key);

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage("images/posters/venom.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      kMainAppColor.withOpacity(0.95),
                      Colors.black.withOpacity(0.3)
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Venom",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(2, 2))
                            ]),
                      ),
                      Row(
                        children: [
                          StarsRatingComponent(rating: 5),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "5",
                            style: TextStyle(color: Color(0xFFFBCA78)),
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
      ],
    );
  }
}
