import 'package:flutter/material.dart';
import 'package:grouu/ui/register/styles/register_styles.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 28.0),
      height: MediaQuery.of(context).copyWith().size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Center(
          child: Container(
              height: 6.0,
              width: 96.0,
              decoration: BoxDecoration(
                  color: HexColor.fromHex("#D9D9D9"),
                  borderRadius: BorderRadius.circular(20.0))),
        ),
        Image.asset("assets/images/eating_grouu_together.png"),
        Center(
          child: Text("Pendaftaran Berhasil", style: RegisterStyles.title),
        ),
        Center(
          child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
              textAlign: TextAlign.center,
              style: RegisterStyles.textMedium),
        ),
        Expanded(child: SizedBox.expand()),
        RoundedButtonWidget(
          buttonColor: Color(0xffFFF5C3),
          buttonText: "Tambah info adik atau kakak",
          textColor: Color(0xff13B2CC),
          onPressed: () async {
            Navigator.of(context)
                .pushNamed(Routes.child_info_add)
                .then((value) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.home, (Route<dynamic> route) => false);
            });
          },
        ),
        SizedBox(height: 12),
        RoundedButtonWidget(
          buttonText: "Mulai Jelajah",
          textColor: Colors.white,
          onPressed: () async {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.home, (Route<dynamic> route) => false);
          },
        ),
      ]),
    );
  }
}
