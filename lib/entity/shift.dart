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
}

class ShiftBlock {
  final String? dateName;
  final ShiftValue value;

  ShiftBlock({this.dateName, required this.value});
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
