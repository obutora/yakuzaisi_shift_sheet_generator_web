import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/widget/preview_week_month_card.dart';

import '../text/title_with_marker.dart';

class ShiftTypeSelector extends ConsumerWidget {
  const ShiftTypeSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shift = ref.watch(shiftProvider);

    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWithMarker(
          title: 'シフトタイプを選んでください',
          iconData: CupertinoIcons.calendar,
          description: '作成できるシフトは2種類あります。\nニーズに合わせたシフトタイプを選んでください。',
        ),
        const SizedBox(height: 12),
        //NOTE : responsive
        //NOTE: スクリーンサイズが小さい時はスマホの可能性があるので、caution
        size.width < 600
            ? LimitedBox(
                maxWidth: 400,
                child: FittedBox(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: kBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.exclamationmark_triangle,
                          color: kPcolor1,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '申し訳ありません。\nスマホでは画像をスクショでしか保存できません...\n配布したい方はPCでお試しください。',
                          style: kCaption.copyWith(color: kPcolor1),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(height: 0),
        size.width >= 900
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableViewCard(
                    title: 'Weeklyタイプ',
                    isWeek: true,
                    isSelected: shift.isWeek,
                  ),
                  SelectableViewCard(
                    title: 'Monthlyタイプ',
                    isWeek: false,
                    isSelected: !shift.isWeek,
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableViewCard(
                    title: 'Weeklyタイプ',
                    isWeek: true,
                    isSelected: shift.isWeek,
                  ),
                  SizedBox(
                    width: 440,
                    child: SelectableViewCard(
                      title: 'Monthlyタイプ',
                      isWeek: false,
                      isSelected: !shift.isWeek,
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
