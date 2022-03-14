import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/button/next_button.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/widget/pdf_contents.dart';
import 'dart:html' as html;

import '../../provider/progress_provider.dart';
import '../../services/convert_image.dart';
import '../text/title_with_marker.dart';

class PreviewResultImageWidget extends ConsumerWidget {
  const PreviewResultImageWidget({
    Key? key,
    required this.contentKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> contentKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressNotifier = ref.watch(progressProvider.notifier);
    final shift = ref.watch(shiftProvider);

    return Column(
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
            child: const DownloadbleImage(),
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

                      html.AnchorElement(
                          href: html.Url.createObjectUrlFromBlob(blob))
                        // ..setAttribute('download', 'kakarituke_shift.png')
                        ..download =
                            'kakarituke_shift_${shift.isWeek ? 'week' : 'month'}${shift.isWeek ? '' : '_' + shift.date.month.toString() + '月'}.png'
                        ..click();
                      // ..remove();
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
        const SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: FittedBox(
            child: Row(
              children: [
                NextButton(
                  title: '前にもどる',
                  color: kBgColor,
                  textColor: kPcolor1,
                  onPressed: () {
                    progressNotifier.change(3);
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                NextButton(
                  title: 'もう一度作る',
                  onPressed: () {
                    progressNotifier.change(0);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        FittedBox(
          child: NextButton(
            color: kBgColor,
            textColor: kPcolor1,
            title: 'トップページにもどる',
            onPressed: () {
              launch('https://iru-yo.com/');
            },
          ),
        ),
      ],
    );
  }
}
