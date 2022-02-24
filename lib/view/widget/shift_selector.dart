import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/entity/shift.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/selected_shift_block_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/services/shift_service.dart';

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

    final selectedNotifier = ref.watch(selectedShiftBlockProvider.notifier);

    late ValueNotifier<String> selectedWeekState = useState('日');
    late ValueNotifier<ShiftValue> changeAllState = useState(ShiftValue.all);

    return Container(
      height: shift.isWeek ? 340 : 880,
      width: size.width >= 720 ? 600 : size.width * 0.8,
      padding: const EdgeInsets.all(20),
      decoration: kCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !shift.isWeek
              ? Center(
                  child: FittedBox(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                            padding: const EdgeInsets.symmetric(vertical: 4),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                                      style:
                                                          kSmallText.copyWith(
                                                              color: kPcolor1),
                                                    )))
                                                .toList(),
                                            onChanged: (String? e) {
                                              selectedWeekState.value = e!;
                                              selectedNotifier.changeIndex(32);
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            focusColor: kBgColor,
                                            dropdownColor: Colors.white,
                                            iconEnabledColor: kPcolor1,
                                            items: ShiftValue.values
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    onTap: () {
                                                      final weekDay = ShiftService
                                                          .calcWeekDay(
                                                              selectedWeekState
                                                                  .value);

                                                      shift.shiftTable!
                                                          .asMap()
                                                          .forEach(
                                                              (index, value) {
                                                        if (value.date!
                                                                .weekday ==
                                                            weekDay) {
                                                          shiftNotifier
                                                              .changeShiftBlock(
                                                                  index, e);
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                      e.typeName,
                                                      style:
                                                          kSmallText.copyWith(
                                                              color: kPcolor1),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (ShiftValue? e) {
                                              changeAllState.value = e!;
                                              selectedNotifier.init();
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
                    ),
                  ),
                )
              : const SizedBox(),
          GridView.builder(
              itemCount: shift.isWeek
                  ? 14
                  : ShiftService.shiftLength(shift.date) +
                      7 +
                      (shift.date.weekday - 1),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 80),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: ShiftService.widgetSelector(
                            index: index,
                            isWeek: shift.isWeek,
                            shift: shift,
                            isPreview: false)));
              }),
          Center(
            child: FittedBox(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                      color: kBgColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.info_circle_fill,
                        color: kPcolor1,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'OKと書かれている■をタップすると\nシフトを切り替えることができます。',
                        style: ksubHeading.copyWith(
                            color: kPcolorTint2, letterSpacing: 1.6),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
