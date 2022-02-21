import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/selected_shift_block_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/provider/shift_provider.dart';
import 'package:yakuzaisi_shift_sheet_generator_web/view/animation/easing.dart';

import '../../../const.dart';
import '../../../entity/shift.dart';

class MonthShiftWidget extends ConsumerWidget {
  const MonthShiftWidget({
    Key? key,
    required this.index,
    required this.minus,
    required this.isPreview,
  }) : super(key: key);

  final int index;
  final int minus;
  final bool isPreview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Shift shift = ref.watch(shiftProvider);
    final shiftNotifier = ref.watch(shiftProvider.notifier);
    final selectedBlock = ref.watch(selectedShiftBlockProvider);
    final selectedNotifier = ref.watch(selectedShiftBlockProvider.notifier);

    //indexは月火水木金土日の7個が最初に含まれるため0を含む6を引く
    final ShiftValue shiftValue = shift.shiftTable![index - minus].value;

    return isPreview == true
        ? Column(
            children: [
              Text(
                '${shift.date.month}/${index - (minus - 1)}',
                style: kCaption.copyWith(color: kPcolor1),
              ),
              const SizedBox(height: 4),
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: shiftValue.bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    shiftValue.typeName,
                    style: kSmallText.copyWith(color: shiftValue.textColor),
                  ),
                ),
              ),
            ],
          )
        : selectedBlock.index == (index - minus)
            ? EasingAnimation(
                easingDirection: Easing.topIn,
                curve: Curves.easeOutCirc,
                delayInMilliseconds: 0,
                durationInMilliseconds: 120,
                moveAmount: 200,
                child: Column(
                  children: [
                    Text(
                      '${shift.date.month}/${index - (minus - 1)}',
                      style: kCaption.copyWith(color: kPcolor1),
                    ),
                    const SizedBox(height: 4),
                    ClosedSelectableShiftBlock(
                      shiftValue: shiftValue,
                      onTap: () {
                        shiftNotifier.changeShiftBlock(
                            index - minus, shiftValue.next);
                        selectedNotifier.changeIndex(index - minus);
                      },
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Text(
                    '${shift.date.month}/${index - (minus - 1)}',
                    style: kCaption.copyWith(color: kPcolor1),
                  ),
                  const SizedBox(height: 4),
                  ClosedSelectableShiftBlock(
                    shiftValue: shiftValue,
                    onTap: () {
                      shiftNotifier.changeShiftBlock(
                          index - minus, shiftValue.next);
                      selectedNotifier.changeIndex(index - minus);
                    },
                  ),
                ],
              );
    // : Column(
    //     children: [
    // Text(
    //   '${shift.date.month}/${index - (minus - 1)}',
    //   style: kCaption.copyWith(color: kPcolor1),
    // ),
    // const SizedBox(height: 4),
    //       PopupMenuButton(
    //         onSelected: (ShiftValue value) {
    //           // print(value);
    //           // print(index - 7);

    //           shiftNotifier.changeShiftBlock(index - minus, value);
    //         },
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(20),
    //         ),
    //         tooltip: 'タップで変更できます',
    //         iconSize: 48,
    //         icon: Container(
    //           height: 48,
    //           width: 48,
    //           decoration: BoxDecoration(
    //             color: shiftValue.bgColor,
    //             borderRadius: BorderRadius.circular(12),
    //           ),
    //           child: Stack(
    //             children: [
    //               Center(
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(bottom: 8),
    //                   child: Text(
    //                     shiftValue.typeName,
    //                     style: kSmallText.copyWith(
    //                         color: shiftValue.textColor),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 48,
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(top: 32),
    //                   child: Text(
    //                     '▼',
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                       fontSize: 8,
    //                       color: shiftValue.textColor,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         itemBuilder: (context) {
    //           return ShiftValue.values
    //               .map((ShiftValue e) => PopupMenuItem(
    //                     value: e,
    //                     child: Text(
    //                       e.typeName,
    //                       style: kHeading.copyWith(color: kPcolor1),
    //                     ),
    //                   ))
    //               .toList();
    //         },
    //       ),
    //       const SizedBox(height: 12),
    //     ],
    //   );
  }
}

// Widget monthShiftWidget(Shift shift, ShiftNotifier notifier, int index,
//     int minus, bool? isPreview) {
//   //indexは月火水木金土日の7個が最初に含まれるため0を含む6を引く
//   final ShiftValue shiftValue = shift.shiftTable![index - minus].value;

//   return isPreview == true
//       ? Column(
//           children: [
//             Text(
//               '${shift.date.month}/${index - (minus - 1)}',
//               style: kCaption.copyWith(color: kPcolor1),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 48,
//               width: 48,
//               decoration: BoxDecoration(
//                 color: shiftValue.bgColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   shiftValue.typeName,
//                   style: kSmallText.copyWith(color: shiftValue.textColor),
//                 ),
//               ),
//             ),
//           ],
//         )
//       : Column(
//           children: [
//             Text(
//               '${shift.date.month}/${index - (minus - 1)}',
//               style: kCaption.copyWith(color: kPcolor1),
//             ),
//             const SizedBox(height: 4),
//             PopupMenuButton(
//               onSelected: (ShiftValue value) {
//                 // print(value);
//                 // print(index - 7);

//                 notifier.changeShiftBlock(index - minus, value);
//               },
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               tooltip: 'タップで変更できます',
//               iconSize: 48,
//               icon: Container(
//                 height: 48,
//                 width: 48,
//                 decoration: BoxDecoration(
//                   color: shiftValue.bgColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Stack(
//                   children: [
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: Text(
//                           shiftValue.typeName,
//                           style:
//                               kSmallText.copyWith(color: shiftValue.textColor),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 48,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 32),
//                         child: Text(
//                           '▼',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 8,
//                             color: shiftValue.textColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               itemBuilder: (context) {
//                 return ShiftValue.values
//                     .map((ShiftValue e) => PopupMenuItem(
//                           value: e,
//                           child: Text(
//                             e.typeName,
//                             style: kHeading.copyWith(color: kPcolor1),
//                           ),
//                         ))
//                     .toList();
//               },
//             ),
//             const SizedBox(height: 12),
//           ],
//         );
// }

//NOTE: WeeklyTypeのときにシフトを選択する為のWidget
class WeekShiftWidget extends HookConsumerWidget {
  const WeekShiftWidget({
    Key? key,
    required this.index,
    required this.isPreview,
  }) : super(key: key);

  final int index;
  final bool isPreview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Shift shift = ref.watch(shiftProvider);
    final shiftNotifier = ref.watch(shiftProvider.notifier);
    final selectedBlock = ref.watch(selectedShiftBlockProvider);
    final selectedNotifier = ref.watch(selectedShiftBlockProvider.notifier);

    final ShiftValue shiftValue = shift.shiftTable![index - 7].value;

    return isPreview == true
        ? Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: shiftValue.bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                shiftValue.typeName,
                style: kSmallText.copyWith(color: shiftValue.textColor),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: selectedBlock.index == (index - 7)
                ? EasingAnimation(
                    easingDirection: Easing.topIn,
                    curve: Curves.easeOutCirc,
                    delayInMilliseconds: 0,
                    durationInMilliseconds: 120,
                    moveAmount: 200,
                    child: ClosedSelectableShiftBlock(
                      shiftValue: shiftValue,
                      onTap: () {
                        shiftNotifier.changeShiftBlock(
                            index - 7, shiftValue.next);
                        selectedNotifier.changeIndex(index - 7);
                      },
                    ),
                  )
                : ClosedSelectableShiftBlock(
                    shiftValue: shiftValue,
                    onTap: () {
                      shiftNotifier.changeShiftBlock(
                          index - 7, shiftValue.next);
                      selectedNotifier.changeIndex(index - 7);
                    },
                  ),
          );
  }
}

//NOTE: PopupButtonを使う実装
// Widget weekShiftWidget({
//   required Shift shift,
//   required ShiftNotifier shiftNotifier,
//   required int index,
//   bool? isPreview,
//   SelectedShiftBlock? selectedBlock,
//   SelectedShiftBlockNotifier? selectedShiftBlockNotifier,
// }) {
//   final ShiftValue shiftValue = shift.shiftTable![index - 7].value;

//   return isPreview == true
//           ? Container(
//               height: 48,
//               width: 48,
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               decoration: BoxDecoration(
//                 color: shiftValue.bgColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   shiftValue.typeName,
//                   style: kSmallText.copyWith(color: shiftValue.textColor),
//                 ),
//               ),
//             )
//           : ClosedSelectableShiftBlock(
//               shiftValue: shiftValue,
//               onTap: () {
//                 selectedShiftBlockNotifier!.changeIndex(index - 7);
//                 // print(blockState.index);
//               },
//             )
//       // PopupMenuButton(
//       //   shape: RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.circular(20),
//       //   ),
//       //   onSelected: (ShiftValue value) {
//       //     // print(value);
//       //     // print(index - 7);

//       //     notifier.changeShiftBlock(index - 7, value);
//       //   },
//       //   tooltip: 'タップで変更できます',
//       //   iconSize: 48,
//       //   icon: Container(
//       //     height: 48,
//       //     width: 48,
//       //     decoration: BoxDecoration(
//       //       color: shiftValue.bgColor,
//       //       borderRadius: BorderRadius.circular(12),
//       //     ),
//       //     child: Stack(
//       //       children: [
//       //         Center(
//       //           child: Padding(
//       //             padding: const EdgeInsets.only(bottom: 8),
//       //             child: Text(
//       //               shiftValue.typeName,
//       //               style: kSmallText.copyWith(color: shiftValue.textColor),
//       //             ),
//       //           ),
//       //         ),
//       //         SizedBox(
//       //           width: 48,
//       //           child: Padding(
//       //             padding: const EdgeInsets.only(top: 32),
//       //             child: Text(
//       //               '▼',
//       //               textAlign: TextAlign.center,
//       //               style:
//       //                   TextStyle(fontSize: 8, color: shiftValue.textColor),
//       //             ),
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       //   itemBuilder: (context) {
//       //     return ShiftValue.values
//       //         .map((ShiftValue e) => PopupMenuItem(
//       //               value: e,
//       //               child: Text(
//       //                 e.typeName,
//       //                 style: kHeading.copyWith(color: kPcolor1),
//       //               ),
//       //             ))
//       //         .toList();
//       //   },
//       // ),
//       // const SizedBox(height: 12),
//       ;
// }

class ClosedSelectableShiftBlock extends StatelessWidget {
  const ClosedSelectableShiftBlock({
    Key? key,
    required this.shiftValue,
    required this.onTap,
  }) : super(key: key);

  final ShiftValue shiftValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: shiftValue.bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  shiftValue.typeName,
                  style: kSmallText.copyWith(color: shiftValue.textColor),
                ),
              ),
            ),
            SizedBox(
              width: 48,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  '▼',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8, color: shiftValue.textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//NOTE: シフト入力画面で、タップしたときにWidgetを切り替えるためのWidget
// Widget SelctableSwicher() {}
