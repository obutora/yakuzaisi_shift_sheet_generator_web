import 'package:flutter/material.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';

enum ShiftValue {
  all,
  am,
  pm,
  holiday,
  close,
}

extension ShiftValueName on ShiftValue {
  String get typeName {
    switch (this) {
      case ShiftValue.all:
        return 'OK';
      case ShiftValue.am:
        return '午前';
      case ShiftValue.pm:
        return '午後';
      case ShiftValue.holiday:
        return '休み';
      case ShiftValue.close:
        return '閉局';
      default:
        return '';
    }
  }

  //indexが次のValueを返す
  ShiftValue get next {
    switch (this) {
      case ShiftValue.all:
        return ShiftValue.am;
      case ShiftValue.am:
        return ShiftValue.pm;
      case ShiftValue.pm:
        return ShiftValue.holiday;
      case ShiftValue.holiday:
        return ShiftValue.close;
      case ShiftValue.close:
        return ShiftValue.all;
      default:
        return ShiftValue.all;
    }
  }

  Color get bgColor {
    switch (this) {
      case ShiftValue.all:
        return kPcolor1;
      case ShiftValue.am:
        return kBgColor;
      case ShiftValue.pm:
        return kBgColor;
      case ShiftValue.holiday:
        return kSurface;
      case ShiftValue.close:
        return kSurface;
      default:
        return Colors.white;
    }
  }

  Color get textColor {
    switch (this) {
      case ShiftValue.all:
        return Colors.white;
      case ShiftValue.am:
        return kPcolor1;
      case ShiftValue.pm:
        return kPcolor1;
      case ShiftValue.holiday:
        return kPcolor1;
      case ShiftValue.close:
        return kPcolor1;
      default:
        return Colors.white;
    }
  }
}

class ShiftBlock {
  final DateTime? date;
  final ShiftValue value;

  ShiftBlock({this.date, required this.value});
}

class Shift {
  final bool isWeek;
  final DateTime date;
  final String? name;
  final String? ruby;
  final String? storeName;
  final String? address;
  final String? tel;
  final List<ShiftBlock>? shiftTable;

  Shift({
    required this.isWeek,
    required this.date,
    this.name,
    this.ruby,
    this.storeName,
    this.address,
    this.tel,
    this.shiftTable,
  });

  Shift copyWith({
    bool? isWeek,
    DateTime? date,
    String? name,
    String? ruby,
    String? storeName,
    String? address,
    String? tel,
    List<ShiftBlock>? shiftTable,
  }) {
    return Shift(
      isWeek: isWeek ?? this.isWeek,
      date: date ?? this.date,
      name: name ?? this.name,
      ruby: ruby ?? this.ruby,
      storeName: storeName ?? this.storeName,
      address: address ?? this.address,
      tel: tel ?? this.tel,
      shiftTable: shiftTable ?? this.shiftTable,
    );
  }
}
