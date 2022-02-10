import 'package:flutter/material.dart';

import '../../const.dart';
import '../decoration/card_box_decoration.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                value: 2022, //TODO Switch
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(12),
                focusColor: kBgColor,
                dropdownColor: Colors.white,
                iconEnabledColor: kPcolor1,
                items: [2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030]
                    .map((year) {
                  return DropdownMenuItem(
                    value: year,
                    child: Text(
                      '$year年',
                      style: kSmallText.copyWith(color: kPcolor1),
                    ),
                  );
                }).toList(),
                onChanged: (year) {
                  print(year);
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
                value: 12, //TODO Switch
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
                onChanged: (month) {
                  print(month);
                }),
          ),
        ],
      ),
    );
  }
}
