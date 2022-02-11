import 'package:hooks_riverpod/hooks_riverpod.dart';

final progressProvider = StateNotifierProvider(((ref) => progressNotifier()));

class progressNotifier extends StateNotifier<int> {
  progressNotifier() : super(4);
  void change(int e) {
    state = e;
  }
}
