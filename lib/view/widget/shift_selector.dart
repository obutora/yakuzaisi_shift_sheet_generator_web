import 'package:flutter/material.dart';

import '../../const.dart';
import '../decoration/card_box_decoration.dart';

class ShiftSelector extends StatelessWidget {
  const ShiftSelector({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: size.width >= 720 ? 600 : size.width * 0.8,
      padding: const EdgeInsets.all(20),
      decoration: kCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: kPcolorTint6, width: 1),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '一括設定',
                  style: kSmallText.copyWith(color: kPcolor1),
                ),
                const SizedBox(height: 4),
                Text(
                  '曜日ごとに一気に設定することができます。\n必ず閉局している曜日がある場合などにお使いください。',
                  style: kCaption.copyWith(color: kPcolor1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kBgColor,
                        ),
                        child: DropdownButton(
                            value: '月',
                            underline: const SizedBox(),
                            borderRadius: BorderRadius.circular(12),
                            focusColor: kBgColor,
                            dropdownColor: Colors.white,
                            iconEnabledColor: kPcolor1,
                            items: ['月', '火', '水', '木', '金', '土', '日']
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e + '曜日',
                                      style:
                                          kSmallText.copyWith(color: kPcolor1),
                                    )))
                                .toList(),
                            onChanged: (e) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'をすべて',
                          style: kCaption.copyWith(color: kPcolor1),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kBgColor,
                        ),
                        child: DropdownButton(
                            value: '〇',
                            underline: const SizedBox(),
                            borderRadius: BorderRadius.circular(12),
                            focusColor: kBgColor,
                            dropdownColor: Colors.white,
                            iconEnabledColor: kPcolor1,
                            items: [
                              '〇',
                              '×',
                              '午前',
                              '午後',
                              '閉局',
                            ]
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style:
                                          kSmallText.copyWith(color: kPcolor1),
                                    )))
                                .toList(),
                            onChanged: (e) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'にする',
                          style: kCaption.copyWith(color: kPcolor1),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          GridView.builder(
              itemCount: 37,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 80),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: index <= 6
                          ? [
                              Text(
                                index.toString(),
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
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: kPcolor1,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    '〇',
                                    style:
                                        kCaption.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                    ),
                  )),
        ],
      ),
    );
  }
}
