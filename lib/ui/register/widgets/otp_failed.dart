import 'package:flutter/widgets.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';

class OtpFailedModal extends StatelessWidget {
  const OtpFailedModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 28.0),
      height: MediaQuery.of(context).copyWith().size.height * 0.50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Center(
          child: Container(
              height: 6.0,
              width: 96.0,
              decoration: BoxDecoration(
                  color: HexColor.fromHex("#D9D9D9"),
                  borderRadius: BorderRadius.circular(20.0))),
        ),
        SizedBox(height: 36),
        Image.asset(
          "assets/icons/icon_failed.gif",
          width: 127.0,
          height: 127.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "OTP Salah",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: HexColor.fromHex("#004D55"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            "Please check your OTP and try again",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: HexColor.fromHex("#7B7B7B"),
              height: 1.5,
            ),
          ),
        ),
        Spacer(),
        RoundedButtonWidget(
            buttonText: "Kembali", onPressed: () => Navigator.of(context).pop())
      ]),
    );
  }
}
