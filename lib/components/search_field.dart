import 'package:flutter/material.dart';
import 'package:moviez/utilities/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {Key? key,
      required this.onChange,
      required this.hint,
      required this.withIcon})
      : super(key: key);
  final Function(String value) onChange;
  final String hint;
  final bool withIcon;
  @override
  Widget build(BuildContext context) {
    return TextField(
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
          hintText: hint,
          fillColor: kWidgetBgColor,
          prefixIcon: withIcon
              ? Icon(
                  Icons.search,
                  color: kIconsColor,
                  size: 30,
                )
              : null),
    );
  }
}
