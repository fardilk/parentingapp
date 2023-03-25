import 'package:flutter/material.dart';

class OutlineRoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool? isLoading;

  const OutlineRoundedButtonWidget({
    Key? key,
    required this.buttonText,
    this.buttonColor = Colors.cyan,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return OutlinedButton(
        onPressed: isLoading == true ? null : onPressed,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          side: BorderSide(color: buttonColor),
          backgroundColor: Colors.transparent,
          minimumSize: Size(208, 44),
          padding: EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(25)),
        ),
        child: isLoading == true
            ? SizedBox(
                width: 20.0, height: 20.0, child: CircularProgressIndicator())
            : Text(
                buttonText,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: buttonColor),
              ),
      );
    } else {
      return OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            minimumSize: Size(208, 44),
            padding: EdgeInsets.symmetric(vertical: 12.0),
            side: BorderSide(color: buttonColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(25))),
        icon: SizedBox(
          child: icon ?? SizedBox.shrink(),
          width: 24,
          height: 24,
        ),
        label: Text(
          buttonText,
          style:
              Theme.of(context).textTheme.button!.copyWith(color: buttonColor),
        ),
      );
    }
  }
}
