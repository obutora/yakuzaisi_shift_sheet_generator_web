import 'package:flutter/cupertino.dart';

import '../../const.dart';

class TitleWithMarker extends StatelessWidget {
  const TitleWithMarker({
    Key? key,
    required this.title,
    required this.description,
    required this.iconData,
  }) : super(key: key);

  final String title;
  final String description;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                    height: 12, width: size.width * 0.9, color: kPcolorTint7),
              ),
              FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(iconData, size: 48, color: kPcolor1),
                    const SizedBox(width: 4),
                    Text(
                      title,
                      style: kMidiumText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 12),
            child: Text(
              description,
              style: kCaption.copyWith(color: kBlack, letterSpacing: 1.3),
            ),
          )
        ],
      ),
    );
  }
}
