import 'package:flutter/cupertino.dart';

import '../entity/shift.dart';

class ShiftTextEditingControllers {
  static final nameEditingController = TextEditingController();
  static final rubyEditingController = TextEditingController();
  static final storeEditingController = TextEditingController();
  static final addressEditingController = TextEditingController();
  static final telEditingController = TextEditingController();

  static void update(Shift shift) {
    if (shift.name != null) {
      nameEditingController.text = shift.name!;
    }

    if (shift.ruby != null) {
      rubyEditingController.text = shift.ruby!;
    }

    if (shift.storeName != null) {
      storeEditingController.text = shift.storeName!;
    }

    if (shift.address != null) {
      addressEditingController.text = shift.address!;
    }

    if (shift.tel != null) {
      telEditingController.text = shift.tel!;
    }
  }
}
