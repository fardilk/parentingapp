import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';

class TambahDataGrowthButton extends StatelessWidget {
  final bool visible;
  final bool? withPadding;
  final Function() onTap;
  const TambahDataGrowthButton({
    Key? key,
    required this.visible,
    this.withPadding,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        color: Color(0xff7AD0E2),
        child: Padding(
          padding: withPadding == true
              ? EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
              : EdgeInsets.zero,
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
                  child: Text(
                    "Tambah Data Pertumbuhan Anak",
                    style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff006F7F),
                    ),
                  ),
                ),
                Image.asset(
                  "assets/icons/icon_plus.png",
                  height: 28,
                  width: 28,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
