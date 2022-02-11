import 'dart:html' as html;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/progress_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/card/content_card.dart';
import '../view/button/next_button.dart';
import '../view/text/title_with_marker.dart';
import '../view/widget/month_selector.dart';
import '../view/widget/pdf_contents.dart';
import '../view/widget/shift_selector.dart';
import '../view/widget/shift_type_selector.dart';
import '../view/widget/textinput.dart';

class HomeScreen extends ConsumerWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 120,
              ),
              Center(child: ProgressWidgetSelector()),
              SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressWidgetSelector extends ConsumerStatefulWidget {
  const ProgressWidgetSelector({
    Key? key,
  }) : super(key: key);

  @override
  ProgressWidgetSelectorState createState() => ProgressWidgetSelectorState();
}

class ProgressWidgetSelectorState
    extends ConsumerState<ProgressWidgetSelector> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final shift = ref.watch(shiftProvider);
    final shiftNotifier = ref.watch(shiftProvider.notifier);

    final progress = ref.watch(progressProvider);
    final progressNotifier = ref.watch(progressProvider.notifier);

    final GlobalKey contentKey = GlobalKey();

    //NOTE: シフトタイプ選択
    if (progress == 0) {
      return ContentCard(
        key: const ValueKey(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShiftTypeSelector(shift: shift),
            shift.isWeek
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      size.width >= 800
                          ? const SizedBox(width: 400)
                          : const SizedBox(),
                      const MonthSelector(),
                    ],
                  ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NextButton(
                  title: 'つぎへ進む',
                  onPressed: () {
                    progressNotifier.change(1);
                  },
                ),
              ],
            ),
          ],
        ),
      );

      //NOTE: 基本情報入力
    } else if (progress == 1) {
      return ContentCard(
        key: const ValueKey(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleWithMarker(
                title: 'シフト表の基本情報を入力してください',
                description:
                    'シフト表にかかりつけ薬剤師のお名前や、薬局の連絡先を入れることができます。\n緊急時の連絡先情報を患者さんに提供することができます。',
                iconData: CupertinoIcons.pencil_outline),
            const SizedBox(height: 28),
            TextForm(shiftNotifier: shiftNotifier),
            const SizedBox(height: 40),
            const BackAndNextButtons(
              backIndex: 0,
              nextIndex: 2,
            ),
          ],
        ),
      );
    } else if (progress == 2) {
      return ContentCard(
        key: const ValueKey(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleWithMarker(
                title: '最後にシフトの入力をお願いします',
                description: shift.isWeek
                    ? '緑のボタンを押して、シフト表を作成しましょう！'
                    : '緑のボタンを押して、シフトを作成しましょう！\n一括入力を使うことでカンタンにシフトを入力できます。',
                iconData: CupertinoIcons.briefcase),
            const SizedBox(height: 28),
            ShiftSelector(size: size),
            const SizedBox(height: 40),
            const BackAndNextButtons(backIndex: 1, nextIndex: 3),
          ],
        ),
      );
    } else if (progress == 3) {
      return ContentCard(
        key: const ValueKey(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleWithMarker(
                title: 'シフト表を作成しました',
                description: 'シフト表を作成しました。\nシフト表を確認して、ダウンロード / 印刷することができます。',
                iconData: CupertinoIcons.gift),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPcolorTint8,
                  width: 1,
                ),
              ),
              child: RepaintBoundary(
                key: contentKey,
                child: const PdfContents(),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            NextButton(
                title: '画像としてダウンロード',
                onPressed: () async {
                  RenderRepaintBoundary? renderObject =
                      contentKey.currentContext!.findRenderObject()
                          as RenderRepaintBoundary?;

                  final image = await renderObject!.toImage(pixelRatio: 6.0);
                  final byteData =
                      await image.toByteData(format: ImageByteFormat.png);

                  final pngBytes = byteData!.buffer.asUint8List();
                  final blob =
                      html.Blob([pngBytes], 'application/octet-stream');

                  html.AnchorElement a = html.AnchorElement(
                      href: html.Url.createObjectUrlFromBlob(blob));
                  a.setAttribute('download', 'image.png');
                  a.click();

                  // print(base64);
                }),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FittedBox(
                child: Row(
                  children: [
                    NextButton(
                      title: 'もどる',
                      onPressed: () {
                        progressNotifier.change(2);
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NextButton(
                      title: 'トップへ',
                      onPressed: () {
                        progressNotifier.change(0);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
