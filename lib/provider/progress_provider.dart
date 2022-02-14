import 'package:hooks_riverpod/hooks_riverpod.dart';

final progressProvider = StateNotifierProvider(((ref) => ProgressNotifier()));

class ProgressNotifier extends StateNotifier<int> {
  ProgressNotifier() : super(0);
  void change(int e) {
    state = e;
  }
}
