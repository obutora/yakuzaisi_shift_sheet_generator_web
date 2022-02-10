import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';

import '../../const.dart';
import '../decoration/card_box_decoration.dart';

class MonthSelector extends ConsumerWidget {
  const MonthSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shiftState = ref.watch(shiftProvider);
    final shiftNotifier = ref.watch(shiftProvider.notifier);
    final int nowYear = shiftState.date.year;
    final int nowMonth = shiftState.date.month;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: kCardDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: kBgColor,
            ),
            child: DropdownButton(
                value: nowYear,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(12),
                focusColor: kBgColor,
                dropdownColor: Colors.white,
                iconEnabledColor: kPcolor1,
                items: [
                  2022,
                  2023,
                  2024,
                  2025,
                  2026,
                ].map((year) {
                  return DropdownMenuItem(
                    value: year,
                    child: Text(
                      '$year年',
                      style: kSmallText.copyWith(color: kPcolor1),
                    ),
                  );
                }).toList(),
                onChanged: (dynamic year) {
                  shiftNotifier.changeYear(year as int);
                }),
          ),
          const SizedBox(width: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: kBgColor,
            ),
            child: DropdownButton(
                value: nowMonth,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(12),
                focusColor: kBgColor,
                dropdownColor: Colors.white,
                iconEnabledColor: kPcolor1,
                items: List.generate(12, (index) => index + 1).map((month) {
                  return DropdownMenuItem(
                    value: month,
                    child: Text(
                      '$month月',
                      style: kSmallText.copyWith(color: kPcolor1),
                    ),
                  );
                }).toList(),
                onChanged: (dynamic month) {
                  shiftNotifier.changeMonth(month as int);
                }),
          ),
        ],
      ),
    );
  }
}
