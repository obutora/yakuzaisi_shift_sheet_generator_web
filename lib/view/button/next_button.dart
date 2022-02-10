import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../const.dart';
import '../../provider/progress_provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kPcolorTint1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          child: Text(
            title,
            style: kPageHeading.copyWith(color: Colors.white),
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
    final notifier = ref.watch(progressProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: size.width >= 800
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NextButton(
                  title: '前にもどる',
                  onPressed: () {
                    notifier.change(backIndex);
                  },
                ),
                NextButton(
                  title: 'つぎへ進む',
                  onPressed: () {
                    notifier.change(nextIndex);
                  },
                ),
              ],
            )
          : Column(
              children: [
                NextButton(
                  title: '前にもどる',
                  onPressed: () {
                    notifier.change(backIndex);
                  },
                ),
                const SizedBox(height: 28),
                NextButton(
                  title: 'つぎへ進む',
                  onPressed: () {
                    notifier.change(nextIndex);
                  },
                ),
              ],
            ),
    );
  }
}
