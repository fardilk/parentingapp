import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

class ChildItemWidget extends StatelessWidget {
  const ChildItemWidget({
    super.key,
    required this.childName,
    required this.onTap,
    required this.gender,
    required this.birthday,
    this.image,
  });

  final String childName;
  final Function onTap;
  final String gender;
  final DateTime birthday;
  final Uint8List? image;

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
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(16),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(8))),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: gender == DataConstants.MALE
                  ? Color(0xffAEE3EE)
                  : Color(0xffF8B6C9),
              radius: 20,
              backgroundImage: _bgImage,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          childName,
                          style: TextStyle(
                              fontFamily: FontFamily.avenirLTStd,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          width: 28,
                          height: 16,
                          decoration: BoxDecoration(
                            color: gender == DataConstants.MALE
                                ? Color(0xffDEF4F8)
                                : Color(0xffFFF5C3),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Icon(
                            gender == DataConstants.MALE
                                ? UniconsLine.mars
                                : UniconsLine.venus,
                            size: 12,
                            color: gender == DataConstants.MALE
                                ? Color(0xff00A5C3)
                                : Color(0xffEF741E),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat("d MMMM yyyy").format(birthday),
                      style: TextStyle(
                        fontFamily: FontFamily.avenirLTStd,
                        fontSize: 12,
                        color: Color(0xff676767),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              UniconsLine.pen,
              color: Color(0xffEF741E),
            ),
          ],
        ),
      ),
    );
  }
}
