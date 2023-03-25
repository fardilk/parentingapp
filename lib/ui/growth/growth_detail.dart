import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/data/local/constants/growth_constants.dart';
import 'package:grouu/models/growth/local_combined_growth.dart';
import 'package:grouu/stores/growth/growth_store.dart';

import '../../constants/font_family.dart';
import '../../data/local/constants/data_constants.dart';
import '../../di/components/service_locator.dart';
import '../../models/growth/local_growth.dart';
import '../../utils/ui/color.dart';

class GrowthDetail extends StatefulWidget {
  final StatsType statsType;

  const GrowthDetail({super.key, required this.statsType});

  @override
  State<GrowthDetail> createState() => _GrowthDetailState();
}

class _GrowthDetailState extends State<GrowthDetail> {
  final GrowthStore _growthStore = getIt<GrowthStore>();
  List<LocalGrowth> selectedMaleGrowth = [];
  List<LocalGrowth> selectedFemaleGrowth = [];

  @override
  void initState() {
    super.initState();
    _growthStore.getDetailedNormalTable(widget.statsType);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.90,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.0)),
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 28.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildModalHeader(),
          _buildTitle(),
          _buildSubtitle(),
          SizedBox(height: 22),
          Expanded(
            child: Observer(
              builder: (BuildContext context) {
                return _buildTable(_growthStore.combinedGrowth);
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "Perkembangan ${widget.statsType.typeName}",
        style: TextStyle(
          fontFamily: FontFamily.avenirLTStd,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: HexColor.fromHex("#00A5C3"),
        ),
      ),
    );
  }

  Padding _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "Tracking feature to help parents ensure their newborns, baby, and/or children are within the normal size required by regulated institution",
        style: TextStyle(
          fontFamily: FontFamily.avenirLTStd,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: HexColor.fromHex("#676767"),
          height: 1.4,
        ),
      ),
    );
  }

  _buildTable(List<LocalCombinedGrowth>? combinedGrowth) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFFE1E1E1)),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildTableHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                defaultColumnWidth: FlexColumnWidth(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  ..._buildTableRow(combinedGrowth)?.toList(),
                ],
              ),
            ),
          ),
          _buildTableFooter(),
        ],
      ),
    );
  }

  Container _buildTableFooter() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          width: 1,
          color: Color(0xFFF6F6F6),
        ),
      )),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          "Sumber : WHO Child Growth Standards",
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            fontFamily: FontFamily.avenirLTStd,
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Color(0xff909090),
          ),
        ),
      ),
    );
  }

  _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Usia",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor.fromHex("#242424"),
                  height: 1.4,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Perempuan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor.fromHex("#242424"),
                  height: 1.4,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Laki-laki",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor.fromHex("#242424"),
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTableRow(List<LocalCombinedGrowth>? combinedGrowth) {
    return combinedGrowth?.map((e) {
      return TableRow(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              horizontal: BorderSide(width: 1, color: Color(0xFFF6F6F6)),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                e.age.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor.fromHex("#242424"),
                  height: 1.4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                e.normalFemale,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor.fromHex("#242424"),
                  height: 1.4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                e.normalMale,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor.fromHex("#242424"),
                  height: 1.4,
                ),
              ),
            ),
          ]);
    });
  }

  Column _buildModalHeader() {
    return Column(
      children: [
        Container(
            height: 6.0,
            width: 96.0,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#D9D9D9"),
                borderRadius: BorderRadius.circular(20.0))),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
