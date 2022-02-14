import 'package:hooks_riverpod/hooks_riverpod.dart';

//NOTE: シフト入力画面で、セレクトされているシフトブロックのStateを保持して伝えるためのProvider
final selectedShiftBlockProvider =
    StateNotifierProvider<SelectedShiftBlockNotifier, SelectedShiftBlock>(
        ((ref) => SelectedShiftBlockNotifier(ref)));

class SelectedShiftBlockNotifier extends StateNotifier<SelectedShiftBlock> {
  SelectedShiftBlockNotifier(ref)
      : super(SelectedShiftBlock(
          index: 100, //NOTE: 初期値は0－30の間の値でなければなんでもいい
          isSelected: false,
        ));

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }

  void init() {
    state = state.copyWith(
      isSelected: false,
      index: 100,
    );
  }
}

class SelectedShiftBlock {
  final bool isSelected;
  final int index;
  SelectedShiftBlock({required this.isSelected, required this.index});

  SelectedShiftBlock copyWith({bool? isSelected, int? index}) {
    return SelectedShiftBlock(
      isSelected: isSelected ?? this.isSelected,
      index: index ?? this.index,
    );
  }
}
