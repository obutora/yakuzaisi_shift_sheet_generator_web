import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/const.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/entity/shift.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/progress_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/animation/easing.dart';
import '../view/button/next_button.dart';
import '../view/widget/month_selector.dart';
import '../view/widget/preview_week_month_card.dart';
import '../view/widget/shift_selector.dart';
import '../view/widget/textinput.dart';

class HomeScreen extends ConsumerWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 120,
              ),
              ProgressWidgetSelector(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressWidgetSelector extends ConsumerWidget {
  const ProgressWidgetSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final shift = ref.watch(shiftProvider);
    final shiftNotifier = ref.watch(shiftProvider.notifier);

    final progress = ref.watch(progressProvider);
    final progressNotifier = ref.watch(progressProvider.notifier);

    //NOTE: シフトタイプ選択
    if (progress == 0) {
      return EasingAnimation(
        easingDirection: Easing.leftIn,
        durationInMilliseconds: 1200,
        curve: Curves.easeOutCirc,
        delayInMilliseconds: 600,
        moveAmount: 600,
        control: CustomAnimationControl.play,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShiftTypeSelector(size: size, shift: shift),
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
            )
          ],
        ),
      );

      //NOTE: 基本情報入力
    } else if (progress == 1) {
      return EasingAnimation(
        easingDirection: Easing.leftIn,
        durationInMilliseconds: 1200,
        curve: Curves.easeOutCirc,
        delayInMilliseconds: 600,
        moveAmount: 600,
        control: CustomAnimationControl.playFromStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'シフト表に入れる項目をそれぞれ入力してください🙇',
              style: kMidiumText,
            ),
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
      return EasingAnimation(
        easingDirection: Easing.leftIn,
        durationInMilliseconds: 1200,
        curve: Curves.easeOutCirc,
        delayInMilliseconds: 600,
        moveAmount: 600,
        control: CustomAnimationControl.playFromStart,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '最後にシフトの入力をお願いします👨‍💻',
                style: kMidiumText,
              ),
              const SizedBox(height: 28),
              ShiftSelector(size: size),
              const SizedBox(height: 40),
              const BackAndNextButtons(backIndex: 1, nextIndex: 3),
              const SizedBox(height: 200),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class ShiftTypeSelector extends StatelessWidget {
  const ShiftTypeSelector({
    Key? key,
    required this.size,
    required this.shift,
  }) : super(key: key);

  final Size size;
  final Shift shift;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'シフトタイプを選んでください🔎',
          style: kMidiumText,
        ),
        const SizedBox(height: 28),
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
                children: const [
                  SelectableViewCard(
                    title: 'Weeklyタイプ',
                    isWeek: true,
                    isSelected: true,
                  ),
                  SelectableViewCard(
                    title: 'Monthlyタイプ',
                    isWeek: false,
                    isSelected: false,
                  ),
                ],
              ),
      ],
    );
  }
}
