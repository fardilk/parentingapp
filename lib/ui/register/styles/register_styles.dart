import 'package:flutter/rendering.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/utils/ui/color.dart';

class RegisterStyles {
  static TextStyle title = TextStyle(
    fontFamily: FontFamily.avenirLTStd,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: HexColor.fromHex("#006F7F"),
  );

  static TextStyle textMedium = TextStyle(
    fontFamily: FontFamily.avenirLTStd,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: HexColor.fromHex("#7B7B7B"),
    height: 1.5,
  );

  static TextStyle textSmall = TextStyle(
    fontFamily: FontFamily.avenirLTStd,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: HexColor.fromHex("#7B7B7B"),
    height: 1.5,
  );

  static TextStyle textMediumRegular = TextStyle(
    fontFamily: FontFamily.avenirLTStd,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: HexColor.fromHex("#676767"),
    height: 1.5,
  );
}
