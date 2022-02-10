import 'package:flutter/material.dart';

import '../../../const.dart';

String weekDay(int index) {
  if (index == 0) {
    return '月';
  } else if (index == 1) {
    return '火';
  } else if (index == 2) {
    return '水';
  } else if (index == 3) {
    return '木';
  } else if (index == 4) {
    return '金';
  } else if (index == 5) {
    return '土';
  } else {
    return '日';
  }
}

Widget contentBlock(String input) {
  if (input == '木') {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: kPcolor2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          '午前',
          style: kCaption.copyWith(color: kPcolor1),
        ),
      ),
    );
  } else if (input == '日') {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          '閉局',
          style: kCaption.copyWith(color: kPcolor1),
        ),
      ),
    );
  } else {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: kPcolor1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'OK',
          style: kCaption.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
