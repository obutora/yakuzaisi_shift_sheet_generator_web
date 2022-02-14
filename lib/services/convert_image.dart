import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class ConvertImage {
  static Future<Uint8List> keyToByteImage(GlobalKey key) async {
    RenderRepaintBoundary? renderObject =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary?;

    final image = await renderObject!.toImage(pixelRatio: 5.6);
    

    final byteData = await image.toByteData(format: ImageByteFormat.png);

    final pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }
}
