import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';

import '../../../data/local/constants/growth_constants.dart';

class HomeDataTumbuhHeader extends StatelessWidget {
  final bool visible;
  final String? childHeight;
  final String? childWeight;
  final String? childHead;
  final Resiko? childHeightRisk;
  final Resiko? childWeightRisk;
  final Resiko? childHeadRisk;
  final String? lastUpdated;
  final bool? isHomeWidget;
  final Function() actionOnTap;
  const HomeDataTumbuhHeader({
    Key? key,
    required this.visible,
    this.childHeight,
    this.childWeight,
    this.childHead,
    this.childHeightRisk,
    this.childWeightRisk,
    this.childHeadRisk,
    this.lastUpdated,
    this.isHomeWidget,
    required this.actionOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return Container(
        color: isHomeWidget == true ? Color(0xff7AD0E2) : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(16),
                elevation: isHomeWidget == true ? 0 : 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(16.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChildStats(
                      statsType: StatsType.Height,
                      statsValue: childHeight ?? "0.0",
                      resiko: childHeightRisk ?? Resiko.Unknown,
                    ),
                    ChildStats(
                      statsType: StatsType.Weight,
                      statsValue: childWeight ?? "0.0",
                      resiko: childWeightRisk ?? Resiko.Unknown,
                    ),
                    ChildStats(
                      statsType: StatsType.Head,
                      statsValue: childHead ?? "0.0",
                      resiko: childHeadRisk ?? Resiko.Unknown,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Data terakhir: ${lastUpdated ?? "-"}",
                        style: TextStyle(
                          fontFamily: FontFamily.avenirLTStd,
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xff3E3C3C),
                        ),
                      ),
                    ),
                    isHomeWidget == true
                        ? InkWell(
                            onTap: actionOnTap,
                            child: Image.asset(
                              "assets/icons/icon_plus.png",
                              height: 28,
                              width: 28,
                            ),
                          )
                        : _buildHistoryButton()
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  _buildHistoryButton() {
    return InkWell(
      onTap: actionOnTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFF5C3),
          borderRadius: BorderRadius.circular(500),
        ),
        child: Text(
          "Lihat Riwayat",
          style: TextStyle(
            fontSize: 8,
            color: Color(0xFF00A5C3),
          ),
        ),
      ),
    );
  }
}

class ChildStats extends StatelessWidget {
  final StatsType statsType;
  final String statsValue;
  final Resiko? resiko;
  final bool? isNormalValue;
  final bool? isChildValue;

  const ChildStats({
    Key? key,
    required this.statsType,
    required this.statsValue,
    this.resiko,
    this.isNormalValue,
    this.isChildValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          statsType.typeName +
              (isNormalValue == true ? " Normal" : "") +
              (isChildValue == true ? " Anak" : ""),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: FontFamily.avenirLTStd,
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: Color(0xff3E3C3C),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              statsValue,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff006F7F),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                statsType.typeSuffix,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xff7B7B7B),
                ),
              ),
            ),
          ],
        ),
        resiko != null
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: resiko?.backgroundColor,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: Text(
                  resiko?.name ?? "Normal",
                  style: TextStyle(
                    fontSize: 8,
                    color: resiko?.nameColor,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
