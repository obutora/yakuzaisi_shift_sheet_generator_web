import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedSvgProvider = StateNotifierProvider<SelectedSvgNotifier, int>(
    (ref) => SelectedSvgNotifier());

class SelectedSvgNotifier extends StateNotifier<int> {
  SelectedSvgNotifier() : super(0);

  void change(int index) {
    state = index;
  }
}


// final progressProvider = StateNotifierProvider(((ref) => ProgressNotifier()));

// class ProgressNotifier extends StateNotifier<int> {
//   ProgressNotifier() : super(1);
//   void change(int e) {
//     state = e;
//   }
