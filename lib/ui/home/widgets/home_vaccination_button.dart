import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';

class HomeVaccinationButton extends StatelessWidget {
  final bool visible;
  final String lastName;
  final Function() onTap;
  const HomeVaccinationButton({
    Key? key,
    required this.visible,
    required this.lastName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        color: Color(0xffEDF0BA),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(16),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(16.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16.0,
                  backgroundColor: Color(0xFFEDF0BA),
                  child: Image.asset(
                    "assets/icons/icon_broccoli.png",
                    height: 20.0,
                    width: 20.0,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Lengkapi segera vaksinasi untuk $lastName",
                    style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xff3E3C3C),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/icons/icon_cross.png",
                    height: 12.0,
                    width: 12.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
