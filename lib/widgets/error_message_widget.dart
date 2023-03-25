import 'package:another_flushbar/flushbar_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

Widget showErrorMessage(BuildContext context, String message) {
  if (message.isNotEmpty) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: tr('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
  }
  return SizedBox.shrink();
}
