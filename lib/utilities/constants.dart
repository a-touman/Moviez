import 'package:flutter/material.dart';

const Color kMainAppColor = Color(0xFF161621);
const Color kWidgetBgColor = Color(0xFF1F1F2F);
const Color kIconsColor = Color(0xFF6D6C7A);
const Color kSubHeadingColor = Color(0xFF787E88);
const TextStyle kSubHeadingStyle = TextStyle(
    color: kSubHeadingColor, fontSize: 12, fontWeight: FontWeight.w500);

var kCustomTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none),
  enabled: true,
  filled: true,
  hintStyle: TextStyle(color: kIconsColor),
  hintText: "Enter your name",
  fillColor: kWidgetBgColor,
  prefixIcon: Icon(
    Icons.person,
    color: kIconsColor,
  ),
);
