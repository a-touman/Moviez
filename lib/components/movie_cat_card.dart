import 'package:flutter/material.dart';
import 'package:moviez/screens/movie_genre_screen.dart';
import 'package:moviez/utilities/constants.dart';

class CategoryCard extends StatelessWidget {
  final String category;

  CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print("$category clicked");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieGenrePage(genre: category),
              ));
        },
        child: Container(
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: kWidgetBgColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF161620),
                child: Text(
                  "${getCategoryEmoji(category)}",
                  style: TextStyle(fontSize: 25),
                ),
                radius: 25,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$category",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }

  static String getCategoryEmoji(String genre) {
    switch (genre) {
      case "Horror":
        {
          return "👻";
        }
      case "Comedy":
        {
          return "😁";
        }
      case "Romance":
        {
          return "😍";
        }
      case "Drama":
        {
          return "🎭";
        }
      case "Sci-Fi":
        {
          return "🛸";
        }
      default:
        {
          return "🍿";
        }
    }
  }
}
