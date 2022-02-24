import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/progress_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/selected_svg_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/card/content_card.dart';
import '../repo/svg_image_repo.dart';
import '../view/button/next_button.dart';
import '../view/text/title_with_marker.dart';
import '../view/widget/preview_result_image.dart';
import '../view/widget/shift_selector.dart';
import '../view/widget/shift_type_selector.dart';
import '../view/widget/textinput.dart';

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
        physics: const BouncingScrollPhysics(),
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

    final selectedSvgIndex = ref.watch(selectedSvgProvider);
    final selectedSvgNotifier = ref.watch(selectedSvgProvider.notifier);

    final GlobalKey contentKey = GlobalKey();

    //NOTE: シフトタイプ選択
    if (progress == 0) {
      return ContentCard(
        key: const ValueKey(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ShiftTypeSelector(), //NOTE: シフトタイプ選択のためのWidget
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
      //NOTE: 画像選択
    } else if (progress == 1) {
      return ContentCard(
        key: const ValueKey(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleWithMarker(
                title: 'シフト表にのせる画像を選んでください',
                description: 'あなたのイメージにあったイラストを選んでみてください。',
                iconData: CupertinoIcons.pencil_outline),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: size.width > 560 ? 2 : 1,
                childAspectRatio: 1.1,
                shrinkWrap: true,
                children: SvgImageRepo.svgPaths
                    .map(
                      (String e) => Column(
                        children: [
                          SvgPicture.asset(
                            e,
                            height: 160,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: SvgImageRepo.getPathFromIndex(
                                        selectedSvgIndex) ==
                                    e,
                                focusColor: kPcolor1,
                                activeColor: kPcolor1,
                                hoverColor: kPcolorTint6.withOpacity(0.3),

                                // onChanged: onChanged(),

                                //NOTE: onChangeでProviderにStateを渡すように変更
                                onChanged: (_) {
                                  final int index = SvgImageRepo.getIndex(e);
                                  selectedSvgNotifier.change(index);
                                },
                                shape: const CircleBorder(),
                              ),
                              const Text('この画像にする', style: kHeading),
                            ],
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 40),
            const BackAndNextButtons(
              backIndex: 0,
              nextIndex: 2,
            ),
          ],
        ),
      );
      //NOTE: 基本情報入力
    } else if (progress == 2) {
      return ContentCard(
        key: const ValueKey(2),
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
              backIndex: 1,
              nextIndex: 3,
            ),
          ],
        ),
      );
    } else if (progress == 3) {
      return ContentCard(
        key: const ValueKey(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleWithMarker(
                title: '最後にシフトの入力をお願いします',
                description: shift.isWeek
                    ? '緑のボタンを押して、シフト表を作成しましょう！'
                    : '緑のボタンを押して、シフトを作成しましょう！\n一括入力を使うことでカンタンにシフトを入力できます。',
                iconData: CupertinoIcons.briefcase),
            const SizedBox(height: 12),
            ShiftSelector(size: size),
            const SizedBox(height: 40),
            const BackAndNextButtons(backIndex: 2, nextIndex: 4),
          ],
        ),
      );
    } else if (progress == 4) {
      return ContentCard(
        key: const ValueKey(4),
        child: PreviewResultImageWidget(
          contentKey: contentKey,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
