import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/entity/shift.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/widget/unit/shift_block.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/widget/unit/shift_widget.dart';

import '../../const.dart';
import '../../provider/shift_provider.dart';
import '../decoration/card_box_decoration.dart';

class ShiftSelector extends HookConsumerWidget {
  const ShiftSelector({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shift = ref.watch(shiftProvider);
    final shiftNotifier = ref.watch(shiftProvider.notifier);

    late ValueNotifier<String> selectedWeekState = useState('日');
    late ValueNotifier<ShiftValue> changeAllState = useState(ShiftValue.all);

    // useEffect(() {
    //   selectedWeekState = ValueNotifier('日');
    //   changeAllState = ValueNotifier(ShiftValue.all);
    //   return null;
    // }, const []);

    int shiftLength(DateTime date) {
      final next = DateTime(date.year, date.month + 1, 1);
      final last = next.add(const Duration(days: -1));
      return last.day;
    }

    int calcWeekDay(String weekName) {
      switch (weekName) {
        case '日':
          return 7;
        case '月':
          return 1;
        case '火':
          return 2;
        case '水':
          return 3;
        case '木':
          return 4;
        case '金':
          return 5;
        case '土':
          return 6;
        default:
          return 0;
      }
    }

    return Container(
      height: shift.isWeek ? 240 : 800,
      width: size.width >= 720 ? 600 : size.width * 0.8,
      padding: const EdgeInsets.all(20),
      decoration: kCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !shift.isWeek
              ? Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: kPcolorTint6, width: 1),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: kPcolorTint8,
                        blurRadius: 2,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '一括設定',
                        style: kSmallText.copyWith(color: kPcolor1),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '曜日ごとに一気に設定することができます。\n必ず閉局している曜日がある場合などにお使いください。',
                        style: kCaption.copyWith(color: kPcolor1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: kBgColor,
                              ),
                              child: ValueListenableBuilder<String>(
                                  valueListenable: selectedWeekState,
                                  builder: (context, snapshot, child) {
                                    return DropdownButton(
                                        value: selectedWeekState.value,
                                        underline: const SizedBox(),
                                        borderRadius: BorderRadius.circular(12),
                                        focusColor: kBgColor,
                                        dropdownColor: Colors.white,
                                        iconEnabledColor: kPcolor1,
                                        items: [
                                          '月',
                                          '火',
                                          '水',
                                          '木',
                                          '金',
                                          '土',
                                          '日'
                                        ]
                                            .map((e) => DropdownMenuItem(
                                                value: e,
                                                // onTap: () {
                                                //   print('youbi---------------');
                                                //   print(e);
                                                //   print(changeAllState.value);
                                                // },
                                                child: Text(
                                                  e + '曜日',
                                                  style: kSmallText.copyWith(
                                                      color: kPcolor1),
                                                )))
                                            .toList(),
                                        onChanged: (String? e) {
                                          selectedWeekState.value = e!;
                                        });
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'をすべて',
                                style: kCaption.copyWith(color: kPcolor1),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: kBgColor,
                              ),
                              child: ValueListenableBuilder<ShiftValue>(
                                  valueListenable: changeAllState,
                                  builder: (context, snapshot, child) {
                                    return DropdownButton(
                                        value: changeAllState.value,
                                        underline: const SizedBox(),
                                        borderRadius: BorderRadius.circular(12),
                                        focusColor: kBgColor,
                                        dropdownColor: Colors.white,
                                        iconEnabledColor: kPcolor1,
                                        items: ShiftValue.values
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                onTap: () {
                                                  final weekDay = calcWeekDay(
                                                      selectedWeekState.value);

                                                  shift.shiftTable!
                                                      .asMap()
                                                      .forEach((index, value) {
                                                    if (value.date!.weekday ==
                                                        weekDay) {
                                                      shiftNotifier
                                                          .changeShiftBlock(
                                                              index, e);
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  e.typeName,
                                                  style: kSmallText.copyWith(
                                                      color: kPcolor1),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (ShiftValue? e) {
                                          changeAllState.value = e!;
                                        });
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'にする',
                                style: kCaption.copyWith(color: kPcolor1),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          GridView.builder(
              itemCount: shift.isWeek
                  ? 14
                  : shiftLength(shift.date) + 7 + (shift.date.weekday - 1),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 80),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                print(shift.date.weekday - 1);
                return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: widgetSelector(
                            index, shift.isWeek, shift, shiftNotifier)));
              }),
        ],
      ),
    );
  }
}

List<Widget> widgetSelector(
    int index, bool isWeek, Shift shift, ShiftNotifier shiftNotifier) {
  if (index <= 6) {
    return [
      Text(
        weekDay(index),
        style: kHeading.copyWith(color: kPcolor1),
      )
    ];
  } else if (isWeek) {
    return weekShiftWidget(shift, shiftNotifier, index);
  } else if (index <= 6 + (shift.date.weekday - 1)) {
    return [
      const SizedBox(
        width: 100,
        height: 100,
      )
    ];
  } else {
    return monthShiftWidget(
        shift, shiftNotifier, index, 7 + (shift.date.weekday - 1));
  }
}
