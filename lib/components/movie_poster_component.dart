import 'package:flutter/material.dart';
import 'package:moviez/components/stars_rating.dart';

class MoviePosterComponent extends StatelessWidget {
  MoviePosterComponent(
      {required this.imgURL,
      required this.title,
      required this.rating,
      required this.onPress});
  final String? imgURL;
  final String? title;
  final double? rating;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: onPress,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                errorBuilder: (context, error, stackTrace) => Image.network(
                  // case image url failed
                  "https://source.unsplash.com/random?sig=3",
                  fit: BoxFit.fill,
                ),
                image: NetworkImage(imgURL!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          title!,
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 15,
        ),
        StarsRatingComponent(rating: rating),
      ],
    );
  }
}
