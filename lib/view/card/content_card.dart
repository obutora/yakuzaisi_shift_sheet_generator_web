import 'package:flutter/material.dart';
import 'package:simple_animations/stateless_animation/custom_animation.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/animation/easing.dart';

import '../../const.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return EasingAnimation(
      easingDirection: Easing.leftIn,
      durationInMilliseconds: 1200,
      curve: Curves.easeOutCirc,
      // delayInMilliseconds: 600,
      moveAmount: 600,
      control: CustomAnimationControl.play,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
        width: size.width >= 840 ? 840 : size.width,
        decoration: BoxDecoration(
          // border: Border.all(color: kPcolorTint4, width: 0.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: kPcolor2,
              blurRadius: 1,
              spreadRadius: 3,
            ),
          ],
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}
