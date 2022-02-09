import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';

class StandardTextInputField extends StatelessWidget {
  const StandardTextInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        style: kSmallText.copyWith(color: kPcolorTint3),
        cursorColor: kPcolorTint3,
        decoration: const InputDecoration(
          focusColor: kPcolorTint2,
          fillColor: kPcolor1,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPcolorTint4, width: 0.5),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPcolor1, width: 0.5),
          ),
          prefixIcon: Icon(
            CupertinoIcons.pen,
            color: kPcolorTint3,
          ),
        ),
      ),
    );
  }
}
