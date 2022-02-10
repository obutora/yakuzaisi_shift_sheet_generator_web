import 'dart:html';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/entity/shift.dart';

final shiftProvider =
    StateNotifierProvider<ShiftNotifier, Shift>((ref) => ShiftNotifier(ref));

class ShiftNotifier extends StateNotifier<Shift> {
  ShiftNotifier(ref)
      : super(Shift(
          isWeek: true,
          date: DateTime.now(),
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
}
