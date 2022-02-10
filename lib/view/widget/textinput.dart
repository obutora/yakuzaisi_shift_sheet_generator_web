import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';

import '../decoration/card_box_decoration.dart';

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

class TextForm extends StatelessWidget {
  const TextForm({
    Key? key,
    required this.shiftNotifier,
  }) : super(key: key);

  final ShiftNotifier shiftNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kCardDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'お名前',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
            hintText: '薬剤 氏名',
            onChanged: (value) => shiftNotifier.changeName(value),
          ),
          const SizedBox(height: 40),
          Text(
            'ふりがな',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
            hintText: 'やくざい しめい',
            onChanged: (value) => shiftNotifier.changeRuby(value),
          ),
          const SizedBox(height: 40),
          Text(
            '薬局のお名前',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
            hintText: '〇〇〇薬局',
            onChanged: (value) => shiftNotifier.changeStoreName(value),
          ),
          const SizedBox(height: 40),
          Text(
            '薬局の住所',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
            hintText: '〇〇県〇〇市',
            onChanged: (value) => shiftNotifier.changeAddress(value),
          ),
          const SizedBox(height: 40),
          Text(
            '薬局の連絡先 : TELがオススメ',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
              hintText: '0120-22-2345 ( メールアドレスなどでも構いません )',
              onChanged: (value) => shiftNotifier.changeTEL(value)),
        ],
      ),
    );
  }
}
