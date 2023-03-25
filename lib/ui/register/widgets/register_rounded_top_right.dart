import 'package:flutter/material.dart';

class RegisterRoundedTopRight extends StatelessWidget {
  const RegisterRoundedTopRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
      ),
    );
  }
}
