import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';

class StandardTextInputField extends StatelessWidget {
  const StandardTextInputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onChanged: (String input) {
          onChanged(input);
        },
        style: kSmallText.copyWith(color: kPcolorTint1),
        cursorColor: kPcolorTint3,
        decoration: InputDecoration(
          hintText: hintText,
          focusColor: kPcolorTint2,
          fillColor: kPcolor1,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPcolorTint4, width: 0.5),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPcolor1, width: 0.5),
          ),
          prefixIcon: const Icon(
            CupertinoIcons.pen,
            color: kPcolorTint3,
          ),
        ),
      ),
    );
  }
}
