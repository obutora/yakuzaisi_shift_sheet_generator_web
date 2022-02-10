import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';

import '../view/decoration/card_box_decoration.dart';
import '../view/widget/month_selector.dart';
import '../view/widget/preview_week_month_card.dart';
import '../view/widget/shift_selector.dart';
import '../view/widget/textinput.dart';

class HomeScreen extends ConsumerWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final shift = ref.watch(shiftProvider);
    final shiftNotifier = ref.watch(shiftProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '作りたいシフトのタイプを選んでください',
                style: kHeading,
              ),
              //NOTE : responsive
              size.width >= 840
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableViewCard(
                          title: 'Weeklyタイプ',
                          isWeek: true,
                          isSelected: shift.isWeek,
                        ),
                        SelectableViewCard(
                          title: 'Monthlyタイプ',
                          isWeek: false,
                          isSelected: !shift.isWeek,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SelectableViewCard(
                          title: 'Weeklyタイプ',
                          isWeek: true,
                          isSelected: true,
                        ),
                        SelectableViewCard(
                          title: 'Monthlyタイプ',
                          isWeek: false,
                          isSelected: false,
                        ),
                      ],
                    ),

              //TODO: Monthlyタイプのときのみ選択必要とする
              const SizedBox(height: 20),
              const Text(
                'いつのシフトを作成しますか？',
                style: kHeading,
              ),
              const SizedBox(height: 12),
              const MonthSelector(),

              const SizedBox(height: 40),
              const Text(
                'シフト表に入れる項目をそれぞれ入力してください🙇',
                style: kHeading,
              ),
              const SizedBox(height: 12),
              Container(
                decoration: kCardDecoration(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                      onChanged: (value) =>
                          shiftNotifier.changeStoreName(value),
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
              ),
              const SizedBox(height: 40),

              const Text(
                '最後にシフトの入力をお願いします👨‍💻',
                style: kHeading,
              ),
              const SizedBox(height: 12),

              ShiftSelector(size: size),
            ],
          ),
        ),
      ),
    );
  }
}
