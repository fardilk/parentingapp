import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/vaccine/vaccine_store.dart';
import 'package:grouu/widgets/delete_confirm_widget.dart';
import 'package:grouu/widgets/action_success_modal.dart';
import 'package:grouu/ui/vaccine/widget/vaccination_item_widget.dart';

import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/outline_rounded_button_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:unicons/unicons.dart';

import '../../widgets/show_error_modal.dart';
import 'widget/detail_vaccine_widget.dart';

class DetailVaccinationScreen extends StatefulWidget {
  const DetailVaccinationScreen({super.key});

  @override
  State<DetailVaccinationScreen> createState() =>
      _DetailVaccinationScreenState();
}

class _DetailVaccinationScreenState extends State<DetailVaccinationScreen> {
  ChildrenStore _childrenStore = getIt<ChildrenStore>();
  VaccineStore _vaccineStore = getIt<VaccineStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(_vaccineStore.vaccineId);
  }

  late Vaccination _vaccination;

  @override
  void initState() {
    super.initState();
    _vaccination = _vaccineStore.vaccination as Vaccination;
  }

  @override
  void dispose() {
    // _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [
                SizedBox(height: 16),
                VaccinationItemWidget(
                  image: _childrenStore.profileImage,
                  gender: _childrenStore.gender,
                  label: "Nama Anak",
                  value:
                      ("${_childrenStore.firstName} ${_childrenStore.lastName}"),
                ),
                VaccinationItemWidget(
                    icon: IconlyLight.calendar,
                    label: "Tanggal Vaksin",
                    value: DateFormat("d MMMM yyyy")
                        .format(_vaccination.vaccinationDate!)),
                VaccinationItemWidget(
                  icon: UniconsLine.syringe,
                  label: "Merek Vaksin",
                  value: _vaccination.vaccineBrand!,
                ),
                VaccinationItemWidget(
                  icon: IconlyLight.location,
                  label: "Lokasi",
                  value: _vaccination.locationName!,
                ),
                VaccinationItemWidget(
                  icon: IconlyLight.profile,
                  label: "Nama Tenaga Kesehatan",
                  value: _vaccination.doctorName!,
                ),
                VaccinationItemWidget(
                  icon: IconlyLight.profile,
                  label: "No. Batch Vaksin",
                  value: _vaccination.batchNumber!,
                ),
                VaccinationItemWidget(
                  icon: IconlyLight.profile,
                  label: "Catatan",
                  value: _vaccination.notes!,
                ),
                SizedBox(height: 16),
                _buildHowToDeal()
              ]),
              _buildActionButton()
            ],
          ),
          Observer(
            builder: (context) {
              return _vaccineStore.success
                  ? navigate(context)
                  : _showErrorMessage(_vaccineStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                  visible: _vaccineStore.loading,
                  child: CustomProgressIndicatorWidget());
            },
          )
        ],
      ),
    );
  }

  Widget _buildHowToDeal() {
    return Observer(builder: (context) {
      if (_vaccineStore.vaccineId == 0) {
        return SizedBox();
      }

      Vaccine? vaccine = _vaccineStore.vaccine as Vaccine?;

      if (vaccine?.howToDeal == null) {
        return SizedBox();
      }
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffAEE3EE)),
          color: Color(0xffEEFBFE),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tips Cara Menangani Efek samping",
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xff00A5C3),
              ),
            ),
            SizedBox(height: 4),
            Text(
              vaccine?.howToDeal ?? "",
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff676767),
              ),
            ),
          ],
        ),
      );
    });
  }

  BackAppBar _buildAppBar() {
    return BackAppBar(title: Text(_vaccination.vaccineName));
  }

  Widget _buildActionButton() {
    return Observer(builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlineRoundedButtonWidget(
                buttonText: "Hapus",
                onPressed: () async {
                  _showDeleteModal(context);
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: RoundedButtonWidget(
                  buttonText: "Ubah",
                  onPressed: () async {
                    _navigateToEditVaccination(
                        context, _vaccineStore.vaccination as Vaccination);
                  }),
            ),
          ],
        ),
      );
    });
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            _buildRoundedTop(),
            Container(
              height: 425,
              width: 55,
              decoration: BoxDecoration(
                color: Color(0xffDEF4F8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(76)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildRoundedTop() {
    return Stack(
      children: [
        Container(height: 16, color: Color(0xff7AD0E2)),
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
        )
      ],
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _showSuccessModal(context).then((value) {
        Navigator.of(context).pop(true);
        _vaccineStore.dispose();
        _vaccineStore.clearInput();
      });
    });
    return Container();
  }

  Future<void> _navigateToEditVaccination(
      BuildContext context, Vaccination? vaccination) async {
    await _vaccineStore.setVaccineId(vaccination?.vaccine ?? 0);
    _vaccineStore.setVaccinationId(vaccination?.id ?? 0);
    _vaccineStore.setVaccination(vaccination);
    var results =
        await Navigator.of(context).pushNamed(Routes.edit_vaccination);
    if (results != null) {
      Navigator.of(context).pop(true);
    }
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        showErrorModal(context, "Error", message);
      });
    }

    return SizedBox.shrink();
  }

  _showSuccessModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          Timer(Duration(seconds: 5), () => Navigator.of(context).pop());
          return ActionSuccessModal(
            description:
                "Data vaksin telah berhasil dihapus dalam database kamu",
            title: "Hapus Vaksin Berhasil!",
          );
        });
  }

  _showDeleteModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return DeleteConfirmWidget(
            onConfirmTap: () {
              if (_vaccineStore.vaccineId != 0) {
                _vaccineStore.removeVaccine();
              } else {
                _vaccineStore.deleteVaccination();
              }
            },
            dialogWording: "Yakin ingin hapus data?",
          );
        });
  }
}
