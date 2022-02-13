import 'package:flutter/cupertino.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/entity/shift.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/widget/preview_week_month_card.dart';

import '../text/title_with_marker.dart';

class ShiftTypeSelector extends StatelessWidget {
  const ShiftTypeSelector({
    Key? key,
    required this.shift,
  }) : super(key: key);

  final Shift shift;

  @override
  Widget build(BuildContext context) {
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
