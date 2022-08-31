import 'package:flutter/material.dart';
import 'package:moviez/utilities/constants.dart';

class TicketStyleButton extends StatelessWidget {
  TicketStyleButton(
      {required this.buttonText,
      required this.onPressed,
      this.width = 300,
      this.height = 70});

  final String? buttonText;
  final Function() onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: StadiumBorder(),
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF218D78), Color(0xFF419A87)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 30,
              width: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: kMainAppColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                buttonText ?? " ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
              width: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: kMainAppColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
