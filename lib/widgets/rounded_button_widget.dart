import 'package:flutter/material.dart';

import '../utils/ui/color.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool? isLoading;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return ElevatedButton(
        onPressed: isLoading == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: buttonColor,
            minimumSize: Size(208, 44),
            padding: EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(25))),
        child: isLoading == true
            ? SizedBox(
                width: 20.0, height: 20.0, child: CircularProgressIndicator())
            : Text(
                buttonText,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: textColor),
              ),
      );
    } else {
      return ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: buttonColor,
            minimumSize: Size(208, 44),
            padding: EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: HexColor.fromHex("#E1E1E1"),
                ),
                borderRadius: BorderRadiusDirectional.circular(25))),
        icon: SizedBox(
          child: icon ?? SizedBox.shrink(),
          width: 24,
          height: 24,
        ),
        label: Text(
          buttonText,
          style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
        ),
      );
    }
  }
}
