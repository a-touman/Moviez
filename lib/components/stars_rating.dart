import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarsRatingComponent extends StatelessWidget {
  StarsRatingComponent({required this.rating});
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: true,
      unratedColor: Color(0xFFD2D0D8),
      itemSize: 15,
      initialRating: rating!.round() / 2,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Color(0xFFFBCA78),
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
