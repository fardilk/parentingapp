import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:iconly/iconly.dart';

import '../../../utils/routes/routes.dart';

class HomeLoginButton extends StatelessWidget {
  final bool visible;
  const HomeLoginButton({
    Key? key,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        color: Color(0xff7AD0E2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.onboarding, (Route<dynamic> route) => false,
                  arguments: true);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(16.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  IconlyLight.profile,
                  color: Color(0xff13B2CC),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Login/Sign up untuk fitur lainnya",
                    style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff13B2CC),
                    ),
                  ),
                ),
                Icon(
                  IconlyLight.arrow_right_2,
                  color: Color(0xff13B2CC),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
