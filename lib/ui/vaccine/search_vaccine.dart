import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/preference/preference_store.dart';
import 'package:grouu/stores/vaccine/vaccine_store.dart';
import 'package:grouu/ui/vaccine/styles/vaccine_styles.dart';
import 'package:grouu/ui/vaccine/widget/detail_vaccine_widget.dart';
import 'package:grouu/ui/vaccine/widget/vaccine_item_widget.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/show_success_modal.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../widgets/show_error_modal.dart';

class SearchVaccineScreen extends StatefulWidget {
  const SearchVaccineScreen({super.key});

  @override
  State<SearchVaccineScreen> createState() => _SearchVaccineScreenState();
}

class _SearchVaccineScreenState extends State<SearchVaccineScreen> {
  final PreferenceStore _store = getIt<PreferenceStore>();
  TextEditingController _searchController = TextEditingController();

  final ChildrenStore _childrenStore = getIt<ChildrenStore>();
  final VaccineStore _vaccineStore = getIt<VaccineStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEFBFE),
      appBar: BackAppBar(title: _buildSearchField()),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [_buildVaccineList()]),
            ],
          ),
          Observer(
            builder: (context) {
              return _store.success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                  visible: _store.loading,
                  child: CustomProgressIndicatorWidget());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVaccineList() {
    return Observer(builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _vaccineStore.listVaccineSchedule.isEmpty
              ? [_buildNotFound()]
              : _vaccineStore.listVaccineSchedule.map((e) {
                  if (_childrenStore.selectedChildrenId != 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.shceduleTitle,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.avenirLTStd,
                                fontWeight: FontWeight.w700)),
                        ...e.listVaccination!.map((vaccine) {
                          return VaccineItemWidget(
                            vaccineMonth: vaccine.vaccinationMonth!,
                            birthday: _childrenStore.birthday,
                            onTap: () async {
                              if (vaccine.vaccinationDate != null) {
                                _navigateToDetailVaccination(context, vaccine);
                                return;
                              }
                              _navigateToAddVaccine(context, vaccine);
                            },
                            vaccineName: vaccine.vaccineName,
                            vaccinationDate: vaccine.vaccinationDate,
                            onDetailTap: () async {
                              await _vaccineStore
                                  .setVaccineId(vaccine.vaccine ?? 0);
                              _showDetailModal(context);
                            },
                            isDetail: vaccine.vaccine != null,
                          );
                        }),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.shceduleTitle,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.avenirLTStd,
                              fontWeight: FontWeight.w700)),
                      ...e.listVaccine.map((vaccine) {
                        return VaccineItemWidget(
                          vaccineMonth: vaccine.vaccinationMonth,
                          birthday: _childrenStore.birthday,
                          onTap: () {
                            // Navigator.of(context).pushNamed(Routes.add_vaccination);
                          },
                          vaccineName: vaccine.vaccineName,
                          vaccinationDate: null,
                          onDetailTap: () async {
                            await _vaccineStore.setVaccineId(vaccine.id);
                            _showDetailModal(context);
                          },
                          isDetail: true,
                        );
                      }),
                    ],
                  );
                }).toList(),
        ),
      );
    });
  }

  Column _buildNotFound() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/eating_grouu_together.png"),
        Text("Pencarian tidak ditemukan", style: VaccineStyles.bold),
        SizedBox(height: 16),
        Text(
          "Vaksin yang kamu cari tidak ada. \n Tambahkan ke daftar vaksin yuk",
          style: VaccineStyles.mediumGray,
        ),
        SizedBox(height: 24),
        Observer(builder: (context) {
          return _childrenStore.selectedChildrenId == 0
              ? SizedBox()
              : RoundedButtonWidget(
                  buttonText: "Tambah Vaksin",
                  onPressed: () {
                    _navigateToAddVaccine(context, null);
                  });
        })
      ],
    );
  }

  Widget _buildSearchField() {
    return Observer(builder: (context) {
      return TextFieldWidget(
        contentPadding: EdgeInsets.zero,
        hint: "Cari berdasarkan merk, fungsi, penyakit",
        errorText: null,
        inputAction: TextInputAction.search,
        textController: _searchController,
        prefixIcon: IconlyLight.search,
        fillColor: Colors.white,
        autoFocus: true,
        onChanged: (value) {
          _vaccineStore.setSearchQuery(_searchController.text);
        },
        onFieldSubmitted: (value) {
          if (_childrenStore.selectedChildrenId != 0) {
            _vaccineStore
                .searchRegisteredVaccine(_childrenStore.selectedChildrenId);
          } else {
            _vaccineStore.searchUnregisteredVaccine();
          }
        },
      );
    });
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRoundedTop(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToAddVaccine(
      BuildContext context, Vaccination? vaccine) async {
    await _vaccineStore.setVaccineId(vaccine?.vaccine ?? 0);
    _vaccineStore.setVaccineName(vaccine?.vaccineName ?? "");
    _vaccineStore.setVaccinationId(vaccine?.id ?? 0);
    var results = await Navigator.of(context).pushNamed(Routes.add_vaccination);
    if (results != null) {
      if (!_vaccineStore.loading) {
        _vaccineStore.getRegisteredVaccine(_childrenStore.selectedChildrenId);
        _vaccineStore.dispose();
        _vaccineStore.clearInput();
      }
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _navigateToDetailVaccination(
      BuildContext context, Vaccination? vaccination) async {
    await _vaccineStore.setVaccineId(vaccination?.vaccine ?? 0);
    _vaccineStore.setVaccinationId(vaccination?.id ?? 0);
    _vaccineStore.setVaccination(vaccination);
    var results =
        await Navigator.of(context).pushNamed(Routes.detail_vaccination);
    if (results != null) {
      if (!_vaccineStore.loading) {
        _vaccineStore.getRegisteredVaccine(_childrenStore.selectedChildrenId);
        _vaccineStore.dispose();
        _vaccineStore.clearInput();
      }
      Navigator.of(context).pop(true);
    }
  }

  Stack _buildRoundedTop() {
    return Stack(
      children: [
        Container(height: 16, color: Color(0xff7AD0E2)),
        Container(
          height: 17,
          decoration: BoxDecoration(
            color: Color(0xffEEFBFE),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
        )
      ],
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      showSuccessModal(
              context, "Vaccine Updated", "Vaccine Updated Successfully")
          .then((value) {
        Navigator.of(context).pop(true);
        _store.dispose();
      });
    });
    return Container();
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

  _showDetailModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return DetailVaccineWidget();
        });
  }
}
