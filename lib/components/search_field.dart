import 'package:flutter/material.dart';
import 'package:moviez/utilities/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key, required this.onChange}) : super(key: key);
  final Function(String value) onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        onChanged: onChange,
        keyboardType: TextInputType.text,
        cursorColor: kIconsColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none),
          enabled: true,
          filled: true,
          hintStyle: TextStyle(color: kIconsColor),
          hintText: "Search movie",
          fillColor: kWidgetBgColor,
          prefixIcon: Icon(
            Icons.search,
            color: kIconsColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
