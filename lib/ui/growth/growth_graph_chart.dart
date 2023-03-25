import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/models/growth/local_growth.dart';

import '../../data/sqlite/db/database.dart';

class GrowthGraphChart extends StatefulWidget {
  const GrowthGraphChart({
    Key? key,
    required this.growthData,
    required this.leftGraphLabel,
    this.childGrowthData,
  }) : super(key: key);

  final String leftGraphLabel;
  final List<LocalGrowth> growthData;
  final List<LocalChildGrowth>? childGrowthData;

  @override
  State<GrowthGraphChart> createState() => _GrowthGraphChartState();
}

class _GrowthGraphChartState extends State<GrowthGraphChart> {
  List<FlSpot> maxThresholdHighRisk = [];
  List<FlSpot> minThresholdHighRisk = [];
  List<FlSpot> maxThresholdLowRisk = [];
  List<FlSpot> minThresholdLowRisk = [];
  List<FlSpot> normal = [];
  List<FlSpot> child = [];
  double minY = 0;
  double? maxX;
  double maxGrowthDatas = 1856;

  @override
  void initState() {
    super.initState();
    maxThresholdHighRisk = widget.growthData
        .map((e) => FlSpot(e.day.toDouble(), e.maxThresholdHighRisk))
        .toList();
    minThresholdHighRisk = widget.growthData
        .map((e) => FlSpot(e.day.toDouble(), e.minThresholdHighRisk))
        .toList();
    maxThresholdLowRisk = widget.growthData
        .map((e) => FlSpot(e.day.toDouble(), e.maxThresholdLowRisk))
        .toList();
    minThresholdLowRisk = widget.growthData
        .map((e) => FlSpot(e.day.toDouble(), e.minThresholdLowRisk))
        .toList();
    normal = widget.growthData
        .map((e) => FlSpot(e.day.toDouble(), e.normal))
        .toList();
    child = widget.childGrowthData
            ?.map((e) => FlSpot(e.day.toDouble(), e.growthValue))
            .toList() ??
        [];

    minY = minThresholdHighRisk.first.y;
    int biggestDay = 0;
    try {
      if (widget.childGrowthData != null) {
        biggestDay = widget.childGrowthData!.reduce((a, b) {
          return a.day > b.day ? a : b;
        }).day;
      }
    } catch (e) {}

    if ((biggestDay == 0)) {
      maxX = null;
    } else {
      maxX =
          (biggestDay * 2 < maxGrowthDatas) ? biggestDay * 2 : maxGrowthDatas;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      heightData,
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }

  LineChartData get heightData => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: maxX,
        // maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          fitInsideVertically: true,
          fitInsideHorizontally: true,
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          axisNameWidget: Text(
            "Usia Anak (Bulan)",
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: Color(0xff242424),
            ),
          ),
          sideTitles: bottomTitles(),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              widget.leftGraphLabel,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: Color(0xff242424),
              ),
            ),
          ),
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineNormalRisk,
        lineMaxThresholdLowRisk,
        lineMaxThresholdHighRisk,
        lineMinThresholdLowRisk,
        lineMinThresholdHighRisk,
        if (child.isNotEmpty) lineChildGrowth,
      ];

  FlGridData get gridData {
    int monthIndex = maxX == null
        ? 90
        : (maxX! < 365)
            ? 30
            : 90;

    return FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 5,
      verticalInterval: monthIndex.toDouble(),
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xffE1E1E1),
          strokeWidth: 0.5,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xffE1E1E1),
          strokeWidth: 0.5,
        );
      },
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.transparent),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: Color(0xffb5b5b5),
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: FontFamily.avenirLTStd,
    );

    final intValue = value.toInt();

    if (intValue % 10 == 0) {
      return Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Text(
          intValue.toString(),
          style: style,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Text('', style: style);
    }
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: Color(0xffb5b5b5),
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: FontFamily.avenirLTStd,
    );

    final intValue = value.toInt();
    final monthValue = intValue ~/ 30;
    int monthIndex = maxX == null
        ? 90
        : (maxX! < 365)
            ? 30
            : 90;

    if (intValue % monthIndex == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          monthValue.toString(),
          style: style,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Text('', style: style);
    }
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  SideTitles bottomTitles() => SideTitles(
        getTitlesWidget: bottomTitleWidgets,
        showTitles: true,
        interval: 30,
        reservedSize: 40,
      );

  LineChartBarData get lineNormalRisk => LineChartBarData(
        isCurved: true,
        color: const Color(0xff3ed425),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: normal,
      );

  LineChartBarData get lineMaxThresholdLowRisk => LineChartBarData(
        isCurved: true,
        color: const Color(0xffff9533),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: maxThresholdLowRisk,
      );

  LineChartBarData get lineMaxThresholdHighRisk => LineChartBarData(
        isCurved: true,
        color: const Color(0xffdc3434),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: maxThresholdHighRisk,
      );

  LineChartBarData get lineMinThresholdLowRisk => LineChartBarData(
        isCurved: true,
        color: const Color(0xffff9533),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: minThresholdLowRisk,
      );

  LineChartBarData get lineMinThresholdHighRisk => LineChartBarData(
        isCurved: true,
        color: const Color(0xffdc3434),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: minThresholdHighRisk,
      );

  LineChartBarData get lineChildGrowth => LineChartBarData(
        isCurved: true,
        color: const Color(0xFF008297),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: child,
      );
}
