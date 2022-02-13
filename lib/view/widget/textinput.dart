import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_text_controllers.dart';

import '../decoration/card_box_decoration.dart';

class StandardTextInputField extends StatelessWidget {
  const StandardTextInputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final Function onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 500;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 0 : 12),
      child: TextField(
        controller: controller,
        onChanged: (String input) {
          onChanged(input);
        },
        style: kSmallText.copyWith(color: kPcolorTint1),
        cursorColor: kPcolorTint3,
        decoration: InputDecoration(
          hintText: hintText,
          focusColor: kPcolorTint2,
          fillColor: kPcolor1,
          hintStyle: isSmallScreen
              ? kCaption.copyWith(color: kSecoundary2)
              : kHeading.copyWith(color: kSecoundary2),
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

class TextForm extends ConsumerWidget {
  const TextForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shiftNotifier = ref.watch(shiftProvider.notifier);

    // final TextEditingController nameController = TextEditingController(text: );

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
            hintText: 'かかりつけ 薬剤師名',
            controller: ShiftTextEditingControllers.nameEditingController,
            onChanged: (value) => shiftNotifier.changeName(value),
          ),
          const SizedBox(height: 40),
          Text(
            'ふりがな',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
            hintText: 'ひらがな or カタカナ',
            controller: ShiftTextEditingControllers.rubyEditingController,
            onChanged: (value) => shiftNotifier.changeRuby(value),
          ),
          const SizedBox(height: 40),
          Text(
            '薬局のお名前',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
            hintText: '〇〇〇薬局',
            controller: ShiftTextEditingControllers.storeEditingController,
            onChanged: (value) => shiftNotifier.changeStoreName(value),
          ),
          const SizedBox(height: 40),
          Text(
            '薬局の住所',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
            hintText: '〇〇県〇〇市',
            controller: ShiftTextEditingControllers.addressEditingController,
            onChanged: (value) => shiftNotifier.changeAddress(value),
          ),
          const SizedBox(height: 40),
          Text(
            '薬局の連絡先 : TELがオススメ',
            style: kCaption.copyWith(color: kPcolorTint3),
          ),
          StandardTextInputField(
              hintText: '0120-22-2345 ( メールアドレスなどでも構いません )',
              controller: ShiftTextEditingControllers.telEditingController,
              onChanged: (value) => shiftNotifier.changeTEL(value)),
        ],
      ),
    );
  }
}
