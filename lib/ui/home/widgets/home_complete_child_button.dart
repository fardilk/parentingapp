import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:iconly/iconly.dart';

class HomeCompleteInformationButton extends StatelessWidget {
  final bool visible;
  final Function() onTap;
  final String title;
  final String subtitle;
  const HomeCompleteInformationButton({
    Key? key,
    required this.visible,
    required this.onTap,
    required this.title,
    required this.subtitle,
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
            onPressed: onTap,
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
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/icons/icon_grouu_mini.png",
                            width: 33,
                            height: 33,
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: FontFamily.avenirLTStd,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff13B2CC),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: FontFamily.avenirLTStd,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.5,
                          color: Color(
                            0xff535151,
                          ),
                        ),
                      ),
                    ],
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
