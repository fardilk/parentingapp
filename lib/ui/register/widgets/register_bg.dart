import 'package:flutter/material.dart';

class RegisterGradientBackground extends StatelessWidget {
  const RegisterGradientBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 207,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xff00A5C3),
            Color(0xffAEE3EE),
          ],
          tileMode: TileMode.mirror,
        ),
      ),
    );
  }
}
