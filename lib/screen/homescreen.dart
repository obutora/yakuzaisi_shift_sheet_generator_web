import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/progress_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/services/convert_image.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/card/content_card.dart';
import '../view/button/next_button.dart';
import '../view/text/title_with_marker.dart';
import '../view/widget/pdf_contents.dart';
import '../view/widget/shift_selector.dart';
import '../view/widget/shift_type_selector.dart';
import '../view/widget/textinput.dart';
import 'dart:html' as html;

class HomeScreen extends ConsumerWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 500;
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: isMobile ? 40 : 120,
              ),
              const Center(child: ProgressWidgetSelector()),
              SizedBox(height: isMobile ? 80 : 200),
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
          children: const [
            TitleWithMarker(
                title: 'シフト表の基本情報を入力してください',
                description:
                    'シフト表にかかりつけ薬剤師のお名前や、薬局の連絡先を入れることができます。\n緊急時の連絡先情報を患者さんに提供することができます。',
                iconData: CupertinoIcons.pencil_outline),
            SizedBox(height: 28),
            TextForm(), //NOTE: 基本情報入力
            SizedBox(height: 40),
            BackAndNextButtons(
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
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                    color: kBgColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.info_circle_fill,
                      color: kPcolor1,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'OKと書かれている■をタップすると\nシフトを切り替えることができます。',
                      style: ksubHeading.copyWith(
                          color: kPcolorTint2, letterSpacing: 1.6),
                    ),
                  ],
                )),
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
                description:
                    'シフト表をダウンロード / 印刷することができます。\nWeeklyタイプは横向き、Monthlyタイプは縦向きで\n綺麗に印刷できます',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FittedBox(
                child: Column(
                  children: [
                    NextButton(
                        title: '画像としてダウンロード',
                        onPressed: () async {
                          final pngBytes =
                              await ConvertImage.keyToByteImage(contentKey);
                          final blob = html.Blob([pngBytes], 'image/png');

                          // final url = html.Url.createObjectUrlFromBlob(blob);
                          // html.window.open(
                          //   url,
                          //   'かかりつけシフト表',
                          // );
                          // html.Url.revokeObjectUrl(url);

                          html.AnchorElement(
                              href: html.Url.createObjectUrlFromBlob(blob))
                            // ..setAttribute('download', 'kakarituke_shift.png')
                            ..download = 'kakarituke_shift.png'
                            ..click()
                            ..remove();
                        }),
                    const SizedBox(height: 4),
                    Text(
                      '5秒ほど待つと、画像が表示されます。\n保存してお使いください。',
                      style: kCaption.copyWith(color: kSecoundary2),
                    )
                  ],
                ),
              ),
            ),
            // FutureBuilder(
            //     future: ConvertImage.keyToByteImage(contentKey),
            //     builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
            //       if (snapshot.hasData) {
            //         return Image.memory(snapshot.data!, fit: BoxFit.cover);
            //       } else {
            //         return const CircularProgressIndicator();
            //       }
            //     }),
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
