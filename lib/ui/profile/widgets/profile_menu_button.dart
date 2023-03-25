import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';

class ProfileMenuButton extends StatelessWidget {
  final Function onPress;
  final IconData icon;
  final String title;
  final Color? iconColor;
  final Color? textColor;

  ProfileMenuButton({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.title,
    this.iconColor = const Color(0xff44BED5),
    this.textColor = const Color(0xff242424),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPress(),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
                color: textColor,
                fontFamily: FontFamily.avenirLTStd,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
