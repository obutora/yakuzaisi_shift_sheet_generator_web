//NOTE: 1週間分のシフト確認
import 'package:flutter/material.dart';

import '../../const.dart';
import '../decoration/card_box_decoration.dart';

class SelectableViewCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 400,
      maxHeight: 500,
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
                Checkbox(
                  value: isSelected,
                  focusColor: kPcolor1,
                  activeColor: kPcolor1,
                  // onChanged: onChanged(),

                  //TODO: onChangeでProviderにStateを渡すように変更
                  onChanged: (e) {},
                  shape: const CircleBorder(),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: kSmallText.copyWith(color: kBlack),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: PreviewShiftBlock(
                isWeek: isWeek,
              ),
            ),
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
    Widget contentBlock(String input) {
      if (input == '木') {
        return Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: kPcolor2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '午前',
              style: kCaption.copyWith(color: kPcolor1),
            ),
          ),
        );
      } else if (input == '日') {
        return Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: kSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '閉局',
              style: kCaption.copyWith(color: kPcolor1),
            ),
          ),
        );
      } else {
        return Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: kPcolor1,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '〇',
              style: kCaption.copyWith(color: Colors.white),
            ),
          ),
        );
      }
    }

    String weekDay(int index) {
      if (index == 0) {
        return '月';
      } else if (index == 1) {
        return '火';
      } else if (index == 2) {
        return '水';
      } else if (index == 3) {
        return '木';
      } else if (index == 4) {
        return '金';
      } else if (index == 5) {
        return '土';
      } else {
        return '日';
      }
    }

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
                              color: kPcolor1,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                '〇',
                                style: kCaption.copyWith(color: Colors.white),
                              ),
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
