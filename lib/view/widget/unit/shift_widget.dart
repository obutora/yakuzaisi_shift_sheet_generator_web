import 'package:flutter/material.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';

import '../../../const.dart';
import '../../../entity/shift.dart';

List<Widget> monthShiftWidget(Shift shift, ShiftNotifier notifier, int index) {
  //indexは月火水木金土日の7個が最初に含まれるため0を含む6を引く

  final ShiftValue shiftValue = shift.shiftTable![index - 7].value;

  return [
    Text(
      '${shift.date.month}/${index - 6}',
      style: kCaption.copyWith(color: kPcolor1),
    ),
    const SizedBox(height: 4),
    PopupMenuButton(
      onSelected: (ShiftValue value) {
        // print(value);
        // print(index - 7);

        notifier.changeShiftBlock(index - 7, value);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      tooltip: 'タップで変更できます',
      iconSize: 48,
      icon: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: shiftValue.bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  shiftValue.typeName,
                  style: kSmallText.copyWith(color: shiftValue.textColor),
                ),
              ),
            ),
            SizedBox(
              width: 48,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  '▼',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    color: shiftValue.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        return ShiftValue.values
            .map((ShiftValue e) => PopupMenuItem(
                  value: e,
                  child: Text(
                    e.typeName,
                    style: kHeading.copyWith(color: kPcolor1),
                  ),
                ))
            .toList();
      },
    ),
    const SizedBox(height: 12),
  ];
}

List<Widget> weekShiftWidget(Shift shift, ShiftNotifier notifier, int index) {
  final ShiftValue shiftValue = shift.shiftTable![index - 7].value;
  return [
    PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: (ShiftValue value) {
        // print(value);
        // print(index - 7);

        notifier.changeShiftBlock(index - 7, value);
      },
      tooltip: 'タップで変更できます',
      iconSize: 48,
      icon: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: shiftValue.bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  shiftValue.typeName,
                  style: kSmallText.copyWith(color: shiftValue.textColor),
                ),
              ),
            ),
            SizedBox(
              width: 48,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  '▼',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8, color: shiftValue.textColor),
                ),
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        return ShiftValue.values
            .map((ShiftValue e) => PopupMenuItem(
                  value: e,
                  child: Text(
                    e.typeName,
                    style: kHeading.copyWith(color: kPcolor1),
                  ),
                ))
            .toList();
      },
    ),
    const SizedBox(height: 12),
  ];
}
