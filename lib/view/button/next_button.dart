import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_text_controllers.dart';

import '../../const.dart';
import '../../provider/progress_provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color ?? kPcolorTint1,
          elevation: 3,
          shadowColor: kPcolorTint8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          child: Text(
            title,
            style: kPageHeading.copyWith(color: textColor ?? Colors.white),
          ),
        ));
  }
}

class BackAndNextButtons extends ConsumerWidget {
  const BackAndNextButtons({
    Key? key,
    required this.backIndex,
    required this.nextIndex,
  }) : super(key: key);

  final int backIndex;
  final int nextIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final shift = ref.watch(shiftProvider);
    final notifier = ref.watch(progressProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: size.width >= 800
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NextButton(
                  title: '前にもどる',
                  color: kBgColor,
                  textColor: kPcolor1,
                  onPressed: () {
                    ShiftTextEditingControllers.update(shift);
                    notifier.change(backIndex);
                  },
                ),
                NextButton(
                  title: 'つぎへ進む',
                  onPressed: () {
                    ShiftTextEditingControllers.update(shift);

                    notifier.change(nextIndex);
                  },
                ),
              ],
            )
          : Column(
              children: [
                NextButton(
                  title: '前にもどる',
                  color: kBgColor,
                  textColor: kPcolor1,
                  onPressed: () {
                    ShiftTextEditingControllers.update(shift);
                    notifier.change(backIndex);
                  },
                ),
                const SizedBox(height: 28),
                NextButton(
                  title: 'つぎへ進む',
                  onPressed: () {
                    ShiftTextEditingControllers.update(shift);
                    notifier.change(nextIndex);
                  },
                ),
              ],
            ),
    );
  }
}
