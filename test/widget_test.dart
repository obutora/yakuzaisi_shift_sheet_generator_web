// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/progress_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/screen/homescreen.dart';

// 現在のステートを表示し、その数字を増やす機能を持つボタンを描画
class TestWidget extends ConsumerWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final progressNotifier = ref.watch(progressProvider.notifier);

    return MaterialApp(
      home: ElevatedButton(
        onPressed: () => progressNotifier.change(1),
        child: Text('$progress'),
      ),
    );
  }
}

void main() {
  testWidgets('progressProviderの初期値は0で、change(1)によって1になることを確認', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HomeScreen()));

    // プロバイダ作成時に宣言した通りデフォルト値は `0`
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // ステートの数字を増やし、ボタンを再描画する
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // 増やしたステートの数字が正しく反映されているか
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('the counter state is not shared between tests', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TestWidget()));

    // ステートは共有されないため、tearDown/setUp がなくても `0` から
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
