import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/vaccine/vaccine_store.dart';
import 'package:grouu/ui/vaccine/styles/vaccine_styles.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:intl/intl.dart';

class DetailVaccineWidget extends StatefulWidget {
  const DetailVaccineWidget({super.key});

  @override
  State<DetailVaccineWidget> createState() => _DetailVaccineWidgetState();
}

class _DetailVaccineWidgetState extends State<DetailVaccineWidget> {
  final VaccineStore _vaccineStore = getIt<VaccineStore>();
  final ChildrenStore _childrenStore = getIt<ChildrenStore>();

  late Vaccine _vaccine;
  late DateTime _birthday;

  @override
  void initState() {
    super.initState();
    _vaccine = _vaccineStore.vaccine as Vaccine;
    _birthday = _childrenStore.birthday ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 28.0),
      height: MediaQuery.of(context).copyWith().size.height * 0.80,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDecoration(),
          SizedBox(height: 36),
          Expanded(
              child: SingleChildScrollView(
            child: _detailContent(),
          )),
          _buildChangeScheduleButton()
        ],
      ),
    );
  }

  Widget _buildChangeScheduleButton() {
    return Observer(builder: (context) {
      if (_childrenStore.selectedChildrenId == 0 ||
          _vaccineStore.vaccinationDate != null) {
        return SizedBox();
      }
      return RoundedButtonWidget(
          buttonText: "Ubah Jadwal Vaksin",
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: _vaccineStore.vaccinationSchedule != null
                  ? _vaccineStore.vaccinationSchedule!
                  : DateTime(
                      _birthday.year,
                      _birthday.month + _vaccine.vaccinationMonth,
                      _birthday.day),
              firstDate: DateTime(1900),
              lastDate: DateTime(2050),
            ).then((value) {
              if (value != null) {
                _vaccineStore.setVaccinationSchedule(value);
                _vaccineStore.updateVaccine();
                Navigator.of(context).pop(true);
              }
            });
          });
    });
  }

  Column _detailContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 16),
        Text("Manfaat", style: VaccineStyles.boldMedium),
        Text(_vaccine.benefits ?? "", style: VaccineStyles.text),
        SizedBox(height: 16),
        Text("Indikasi Pemberian", style: VaccineStyles.boldMedium),
        Text(_vaccine.indication ?? "", style: VaccineStyles.text),
        SizedBox(height: 16),
        Text("Kontra Indikasi", style: VaccineStyles.boldMedium),
        Text(_vaccine.contraIndication ?? "", style: VaccineStyles.text),
        SizedBox(height: 16),
        Text("KIPI (Kejadian Ikutan Pasca Imunisasi)",
            style: VaccineStyles.boldMedium),
        Text(_vaccine.sideEffects ?? "", style: VaccineStyles.text),
        SizedBox(height: 16),
        Text("Cara Menangani Efek Samping", style: VaccineStyles.boldMedium),
        Text(_vaccine.howToDeal ?? "", style: VaccineStyles.text),
        SizedBox(height: 16),
        Text("Imunisasi Kejar", style: VaccineStyles.boldMedium),
        Text(_vaccine.imunisasiKejar ?? "", style: VaccineStyles.text),
        SizedBox(height: 16),
        Text("Catatan", style: VaccineStyles.boldMedium),
        Text(_vaccine.notes ?? "", style: VaccineStyles.text),
        SizedBox(height: 16),
        Text("Daftar Merk", style: VaccineStyles.boldMedium),
        Text(_vaccine.vaccineBrands ?? "", style: VaccineStyles.text),
        SizedBox(height: 16),
        Text("Sumber", style: VaccineStyles.boldMedium),
        Text(_vaccine.source ?? "", style: VaccineStyles.text),
      ],
    );
  }

  Center _buildDecoration() {
    return Center(
      child: Container(
          height: 6.0,
          width: 96.0,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#D9D9D9"),
              borderRadius: BorderRadius.circular(20.0))),
    );
  }

  Widget _buildHeader() {
    return Observer(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Imunisasi Dasar", style: VaccineStyles.small),
              Text(_vaccine.vaccineName, style: VaccineStyles.boldColored),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                  _vaccineStore.vaccinationDate != null
                      ? "Sudah Vaksin"
                      : "Jadwal Vaksin",
                  style: VaccineStyles.small),
              _vaccineStore.vaccinationDate != null
                  ? Text(_formatDate(_vaccineStore.vaccinationDate),
                      style: VaccineStyles.boldMedium)
                  : _vaccineStore.vaccinationSchedule != null
                      ? Text(_formatDate(_vaccineStore.vaccinationSchedule),
                          style: VaccineStyles.boldMedium)
                      : Text(
                          _formatDate(DateTime(
                              _birthday.year,
                              _birthday.month + _vaccine.vaccinationMonth,
                              _birthday.day)),
                          style: VaccineStyles.boldMedium)
            ],
          ),
        ],
      );
    });
  }

  String _formatDate(value) {
    return DateFormat("d MMM yyyy").format(value);
  }
}
