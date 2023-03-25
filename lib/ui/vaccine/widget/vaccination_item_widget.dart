import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:grouu/ui/vaccine/styles/vaccine_styles.dart';

class VaccinationItemWidget extends StatelessWidget {
  const VaccinationItemWidget({
    Key? key,
    this.gender,
    required this.label,
    required this.value,
    this.image,
    this.icon,
  }) : super(key: key);

  final String label;
  final String value;
  final String? gender;
  final Uint8List? image;
  final IconData? icon;

  ImageProvider<Object>? get _bgImage {
    if (image != null) {
      return MemoryImage(image!);
    } else {
      return gender == DataConstants.MALE
          ? AssetImage("assets/images/baby_boy_profile.png")
          : AssetImage("assets/images/baby_girl_profile.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            height: 56,
            width: 56,
            child: icon != null
                ? Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(icon, color: Color(0xff00A5C3), size: 12),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        alignment: Alignment.center,
                        fixedSize: Size(32, 32),
                        backgroundColor: Colors.white,
                        shape: CircleBorder(
                            side: BorderSide(
                          color: Color(0xffDEF4F8),
                          width: 1,
                        )),
                      ),
                    ),
                  )
                : Center(
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: Color(0xfff6f6f6),
                      child: CircleAvatar(
                        backgroundColor: gender == DataConstants.MALE
                            ? Color(0xffAEE3EE)
                            : Color(0xffF8B6C9),
                        radius: 30,
                        backgroundImage: _bgImage,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: VaccineStyles.small),
                SizedBox(height: 4),
                Text(value.isEmpty ? "-" : value, style: VaccineStyles.medium),
              ],
            ),
          )
        ],
      ),
    );
  }
}
