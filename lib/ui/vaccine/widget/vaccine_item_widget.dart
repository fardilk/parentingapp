import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

class VaccineItemWidget extends StatelessWidget {
  const VaccineItemWidget({
    super.key,
    required this.onTap,
    required this.vaccineName,
    required this.vaccineMonth,
    this.birthday,
    this.vaccinationDate,
    required this.onDetailTap,
    required this.isDetail,
    this.vaccinationSchedule,
  });

  final Function onTap;
  final Function onDetailTap;
  final String vaccineName;
  final int vaccineMonth;
  final DateTime? birthday;
  final DateTime? vaccinationDate;
  final DateTime? vaccinationSchedule;
  final bool isDetail;

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
            _buildStatusIcon(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vaccineName,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: FontFamily.avenirLTStd,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _buildScheculeText(),
                      style: TextStyle(
                        fontFamily: FontFamily.avenirLTStd,
                        fontSize: 14,
                        color: Color(0xff676767),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isDetail
                ? TextButton(
                    onPressed: () => onDetailTap(), child: Text("Detail Info"))
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    if (birthday == null) {
      return SizedBox();
    } else if (vaccinationDate != null) {
      return Icon(UniconsSolid.check_circle, color: Color(0xff3ED425));
    } else if (DateTime(
            birthday!.year, birthday!.month + vaccineMonth, birthday!.day)
        .isBefore(DateTime.now())) {
      return Icon(IconlyBold.info_circle, color: Color(0xffFF9533));
    } else {
      return Icon(UniconsSolid.check_circle, color: Color(0xffE1E1E1));
    }
  }

  String _buildScheculeText() {
    if (vaccinationDate != null) {
      return "Sudah Vaksin : ${_formatDate(vaccinationDate)}";
    }

    if(vaccinationSchedule != null) {
      return "Jadwal Vaksin : ${_formatDate(vaccinationSchedule)}";
    }

    if (birthday != null) {
      return "Jadwal Vaksin : ${_formatDate(DateTime(birthday!.year, birthday!.month + vaccineMonth, birthday!.day))}";
    }
    String oldString = vaccineMonth < 36
        ? "$vaccineMonth bulan"
        : "${vaccineMonth ~/ 12} tahun";
    return "Jadwal Vaksin pada usia $oldString";
  }

  String _formatDate(value) {
    return DateFormat("d MMM yyyy").format(value);
  }
}
