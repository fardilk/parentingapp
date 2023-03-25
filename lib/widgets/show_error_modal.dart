import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grouu/widgets/action_error_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showErrorModal(BuildContext context, String title, String description) {
  return showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      enableDrag: true,
      isDismissible: true,
      builder: (BuildContext context) {
        Timer(Duration(seconds: 5), () => Navigator.of(context).pop());
        return ActionErrorModal(
          description: description,
          title: title,
        );
      });
}
