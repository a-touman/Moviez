import 'package:flutter/material.dart';
import 'package:moviez/utilities/constants.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({Key? key, required this.onChange}) : super(key: key);
  final Function(String value) onChange;
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChange,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        maxLength: 10,
        cursorColor: kIconsColor,
        decoration: kCustomTextFieldDecoration);
  }
}
