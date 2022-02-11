import 'package:flutter/material.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/widget/unit/shift_widget.dart';

import '../const.dart';
import '../entity/shift.dart';
import '../provider/shift_provider.dart';
import '../view/widget/unit/shift_block.dart';

class ShiftService {
  static int shiftLength(DateTime date) {
    final next = DateTime(date.year, date.month + 1, 1);
    final last = next.add(const Duration(days: -1));
    return last.day;
  }

  static int calcWeekDay(String weekName) {
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

  static List<Widget> widgetSelector(int index, bool isWeek, Shift shift,
      ShiftNotifier shiftNotifier, bool? isPreview) {
    if (index <= 6) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 84),
          child: Text(
            weekDay(index),
            style: kHeading.copyWith(color: kPcolor1),
          ),
        )
      ];
    } else if (isWeek) {
      return weekShiftWidget(shift, shiftNotifier, index, isPreview);
    } else if (index <= 6 + (shift.date.weekday - 1)) {
      return [
        const SizedBox(
          width: 100,
          height: 100,
        )
      ];
    } else {
      return monthShiftWidget(
          shift, shiftNotifier, index, 7 + (shift.date.weekday - 1), isPreview);
    }
  }

  static Shift mockShift() {
    return Shift(isWeek: false, date: DateTime(2022, 1, 1));
  }
}
