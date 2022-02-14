import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/selected_svg_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/repo/svg_image_repo.dart';

import '../../const.dart';
import '../../services/shift_service.dart';

class PdfContents extends ConsumerWidget {
  const PdfContents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shift = ref.watch(shiftProvider);

    final selectedSvgIndex = ref.watch(selectedSvgProvider);

    return FittedBox(
      child: Container(
        color: Colors.white,
        width: shift.isWeek ? 895 : 806,
        height: shift.isWeek ? 620 : 1163,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              shift.isWeek ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            SizedBox(height: shift.isWeek ? 60 : 120),
            Transform.scale(
              scale: 1.5,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/bg_shape.svg',
                      width: shift.isWeek ? 240 : 320,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'あなたの',
                            style: kCaption.copyWith(color: kPcolor1),
                          ),
                          Text(
                            'かかりつけ薬剤師',
                            style: shift.isWeek
                                ? kPageHeading.copyWith(color: kPcolor1)
                                : kMidiumText.copyWith(color: kPcolor1),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: SvgPicture.asset(
                        // 'assets/hero_women.svg',
                        SvgImageRepo.getPathFromIndex(selectedSvgIndex),
                        width: shift.isWeek ? 160 : 200,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shift.ruby ?? '',
                            style: kCaption.copyWith(color: kPcolor1),
                          ),
                          Text(
                            shift.name ?? '',
                            style: shift.isWeek
                                ? kMidiumText.copyWith(color: kPcolor1)
                                : kXLargeText.copyWith(color: kPcolor1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: shift.isWeek ? 1 : 40,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: shift.isWeek ? 100 : 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                      itemCount: shift.isWeek
                          ? 14
                          : ShiftService.shiftLength(shift.date) +
                              7 +
                              (shift.date.weekday - 1),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 4,
                        mainAxisExtent: 80,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: ShiftService.widgetSelector(
                              index: index,
                              isWeek: shift.isWeek,
                              shift: shift,
                              isPreview: true,
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '*やむを得ず予定が変更される場合もあります。ご了承くださいませ。',
                    style: kCaption.copyWith(
                        color: kPcolor1, fontSize: shift.isWeek ? 9 : 12),
                  )
                ],
              ),
            ),
            SizedBox(height: shift.isWeek ? 20 : 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: shift.isWeek ? 120 : 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          shift.storeName ?? '',
                          style: shift.isWeek
                              ? ksubHeading.copyWith(
                                  color: kPcolor1, letterSpacing: 1)
                              : kHeading.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: kPcolor1,
                                  letterSpacing: 1),
                        ),
                        Text(
                          shift.address ?? '',
                          style: kCaption.copyWith(
                              color: kPcolor1,
                              fontSize: shift.isWeek ? 9 : 12,
                              letterSpacing: 1.3),
                        ),
                        Text(
                          shift.tel ?? '',
                          style: kCaption.copyWith(
                              color: kPcolor1,
                              fontSize: shift.isWeek ? 9 : 12,
                              letterSpacing: 1.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
