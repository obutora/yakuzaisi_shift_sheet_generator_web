//NOTE: 1週間分のシフト確認
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/widget/month_selector.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/widget/unit/shift_block.dart';

import '../../const.dart';
import '../decoration/card_box_decoration.dart';

class SelectableViewCard extends ConsumerWidget {
  const SelectableViewCard({
    Key? key,
    required this.title,
    required this.isWeek,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final bool isWeek;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shift = ref.watch(shiftProvider);
    final shiftNotifier = ref.watch(shiftProvider.notifier);

    return LimitedBox(
      maxWidth: 400,
      maxHeight: 640,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(12),
        decoration: kCardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: isSelected,
                    focusColor: kPcolor1,
                    activeColor: kPcolor1,
                    hoverColor: kPcolorTint6.withOpacity(0.3),

                    // onChanged: onChanged(),

                    //NOTE: onChangeでProviderにStateを渡すように変更
                    onChanged: (e) {
                      shiftNotifier.changeIsWeek(isWeek);

                      //shiftTableの表示を変更
                      shiftNotifier.createShiftTable();
                    },
                    shape: const CircleBorder(),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.visible,
                        style: kSmallText.copyWith(color: kBlack),
                      ),
                      Text(
                        isWeek ? 'おおまかなシフトが必要なときに！' : 'より確実に会えるシフト表が必要なときに！',
                        style: kCaption.copyWith(color: kBlack),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: PreviewShiftBlock(
                isWeek: isWeek,
              ),
            ),
            !shift.isWeek && !isWeek
                ? const FittedBox(child: MonthSelector())
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class PreviewShiftBlock extends StatelessWidget {
  const PreviewShiftBlock({Key? key, required this.isWeek}) : super(key: key);

  final bool isWeek;

  @override
  Widget build(BuildContext context) {
    //ブロックに差を付けたいので関数にて定義している

    return isWeek
        ? FittedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['月', '火', '水', '木', '金', '土', '日']
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          children: [
                            Text(
                              e,
                              textAlign: TextAlign.center,
                              style: ksubHeading.copyWith(
                                  color: kPcolor1, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 4),
                            contentBlock(e), //NOTE: Blockを入れる
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, childAspectRatio: 0.7, mainAxisExtent: 50),
            itemCount: 37,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: index <= 6
                      ? [
                          Text(
                            weekDay(index),
                            style: kCaption.copyWith(color: kPcolor1),
                          )
                        ]
                      : [
                          Text(
                            '1/${index - 6}',
                            style: kCaption.copyWith(color: kPcolor1),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: contentBlock(weekDay(index % 7)),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                ),
              );
            },
          );
  }
}
