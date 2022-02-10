import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/entity/shift.dart';

final shiftProvider =
    StateNotifierProvider<ShiftNotifier, Shift>((ref) => ShiftNotifier(ref));

class ShiftNotifier extends StateNotifier<Shift> {
  ShiftNotifier(ref)
      : super(Shift(
          isWeek: true,
          date: DateTime.now(),
          shiftTable:
              List.generate(7, (index) => ShiftBlock(value: ShiftValue.all)),
        ));

  void changeIsWeek(bool isWeek) {
    state = state.copyWith(isWeek: isWeek);
  }

  void changeYear(int year) {
    final int month = state.date.month;
    state = state.copyWith(date: DateTime(year, month, 1));
  }

  void changeMonth(int month) {
    final int year = state.date.year;
    state = state.copyWith(date: DateTime(year, month, 1));
  }

  void changeName(String input) {
    state = state.copyWith(name: input);
  }

  void changeRuby(String input) {
    state = state.copyWith(ruby: input);
  }

  void changeStoreName(String input) {
    state = state.copyWith(storeName: input);
  }

  void changeAddress(String input) {
    state = state.copyWith(address: input);
  }

  void changeTEL(String input) {
    state = state.copyWith(tel: input);
  }

  void createShiftTable() {
    //週刊のときは7個のみ。日付は必要ないのでNull
    if (state.isWeek) {
      state = state.copyWith(
          shiftTable:
              List.generate(7, (index) => ShiftBlock(value: ShiftValue.all)));
    } else {
      //月間のときは先月の
      final next = DateTime(state.date.year, state.date.month + 1, 1);
      final last = next.add(const Duration(days: -1));
      final int lastDay = last.day;
      state = state.copyWith(
          shiftTable: List.generate(
              lastDay,
              (index) => ShiftBlock(
                  dateName: '${state.date.month}/$index',
                  value: ShiftValue.all)));
    }
  }

  void changeShiftBlock(int index, ShiftValue value) {
    List<ShiftBlock> table = state.shiftTable!;

    if (state.isWeek) {
      table[index] = ShiftBlock(value: value);
    } else {
      final String dateName = state.shiftTable![index].dateName!;
      table[index] = ShiftBlock(value: value, dateName: dateName);
    }
    state = state.copyWith(
      shiftTable: table,
    );
  }
}
