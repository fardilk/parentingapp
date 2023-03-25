import 'package:flutter/material.dart';

import '../../constants/font_family.dart';
import '../../utils/ui/color.dart';

class GrowthHowToMeasureModal extends StatelessWidget {
  const GrowthHowToMeasureModal({super.key});

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
        SizedBox(height: 28),
        Center(
          child: Text("Cara Mengukur Tinggi / Panjang Anak",
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: HexColor.fromHex("#006F7F"),
              )),
        ),
        SizedBox(height: 28),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 28),
                Image.asset("assets/images/baby_boy_n_notes.png"),
                SizedBox(height: 28),
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: HexColor.fromHex("#676767"),
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
