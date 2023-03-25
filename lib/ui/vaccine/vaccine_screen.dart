import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/preference/preference_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/stores/vaccine/vaccine_store.dart';
import 'package:grouu/ui/vaccine/widget/detail_vaccine_widget.dart';
import 'package:grouu/ui/vaccine/widget/tab_selector_widget.dart';
import 'package:grouu/ui/vaccine/widget/vaccine_item_widget.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/show_success_modal.dart';
import 'package:grouu/widgets/small_chip_widget.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../utils/locale/wording_utils.dart';
import '../../widgets/show_error_modal.dart';

class VaccineScreen extends StatefulWidget {
  const VaccineScreen({super.key});

  @override
  State<VaccineScreen> createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  final PreferenceStore _store = getIt<PreferenceStore>();
  TextEditingController _searchController = TextEditingController();

  final UserStore _userStore = getIt<UserStore>();
  final ChildrenStore _childrenStore = getIt<ChildrenStore>();
  final VaccineStore _vaccineStore = getIt<VaccineStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_userStore.isLoggedIn) {
      _vaccineStore.getUnregisteredVaccine();
    }

    if (_childrenStore.selectedChildrenId != 0) {
      _vaccineStore.getRegisteredVaccine(_childrenStore.selectedChildrenId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEFBFE),
      appBar: BackAppBar(title: _buildAppbarTitle()),
      floatingActionButton: _buildFab(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [
                _buildTabBar(),
                _buildSearchField(),
                _buildAgeSelector(),
                _buildVaccineList()
              ]),
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
                  visible: _vaccineStore.loading,
                  child: CustomProgressIndicatorWidget());
            },
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomLoginButton(),
    );
  }

  Widget _buildFab() {
    return Observer(builder: (context) {
      if (_childrenStore.selectedChildrenId == 0) {
        return SizedBox();
      }
      return FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff00A5C3),
        onPressed: () async {
          _navigateToAddVaccine(context, null);
        },
      );
    });
  }

  Widget _buildTabBar() {
    return Observer(
      builder: (context) {
        return _userStore.isLoggedIn
            ? Row(
                children: [
                  TabSelectorWidget(
                    active: _vaccineStore.statusIndex == 0,
                    text: "Semua",
                    onTap: () {
                      _vaccineStore.setStatus(0);
                      _vaccineStore.getRegisteredVaccine(
                          _childrenStore.selectedChildrenId);
                    },
                  ),
                  TabSelectorWidget(
                    active: _vaccineStore.statusIndex == 1,
                    text: "Belum",
                    onTap: () {
                      _vaccineStore.setStatus(1);
                      _vaccineStore.getRegisteredVaccine(
                          _childrenStore.selectedChildrenId);
                    },
                  ),
                  TabSelectorWidget(
                    active: _vaccineStore.statusIndex == 2,
                    text: "Sudah",
                    onTap: () {
                      _vaccineStore.setStatus(2);
                      _vaccineStore.getRegisteredVaccine(
                          _childrenStore.selectedChildrenId);
                    },
                  ),
                ],
              )
            : SizedBox();
      },
    );
  }

  Widget _buildAppbarTitle() {
    return Observer(builder: (context) {
      if (_childrenStore.childrens == null ||
          _childrenStore.childrens!.isEmpty) {
        return Text(
          tr("vaccine"),
          style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        );
      } else {
        List<Children> childrens = _childrenStore.childrens as List<Children>;
        return DropdownButton<String>(
          isExpanded: true,
          value: _childrenStore.selectedChildrenId.toString(),
          icon: const Icon(IconlyLight.arrow_down_2, color: Colors.white),
          elevation: 0,
          style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          dropdownColor: Color(0xff13B2CC),
          underline: Container(
            height: 2,
            color: Colors.white,
          ),
          onChanged: (String? value) {
            _childrenStore.selectChildren(childrens.firstWhere(
                (Children element) => element.id.toString() == value));
            _vaccineStore
                .getRegisteredVaccine(_childrenStore.selectedChildrenId);
          },
          items: childrens.map<DropdownMenuItem<String>>((children) {
            return DropdownMenuItem<String>(
              value: children.id.toString(),
              child: Text("${children.firstName} ${children.lastName}"),
            );
          }).toList(),
        );
      }
    });
  }

  Widget? _buildBottomLoginButton() {
    if (_userStore.isLoggedIn) {
      return null;
    }
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xffFFF5C3),
      child: Row(
        children: [
          Icon(
            IconlyLight.profile,
            size: 36,
            color: Color(0xff00A5C3),
          ),
          SizedBox(width: 8),
          Text(
            "Login/Sign up yuk",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xff13B2CC)),
          ),
          Spacer(),
          IconButton(
            onPressed: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.onboarding, (Route<dynamic> route) => false,
                  arguments: true);
            },
            icon: Icon(IconlyBold.arrow_right_circle,
                size: 36, color: Color(0xff00A5C3)),
          )
        ],
      ),
    );
  }

  Widget _buildVaccineList() {
    return Observer(builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: _vaccineStore.listVaccineSchedule.map((e) {
            if (_childrenStore.selectedChildrenId != 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.shceduleTitle,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: FontFamily.avenirLTStd,
                          fontWeight: FontWeight.w700)),
                  ...e.listVaccination!.map((vaccination) {
                    return VaccineItemWidget(
                      vaccineMonth: vaccination.vaccinationMonth!,
                      birthday: _childrenStore.birthday,
                      onTap: () async {
                        if (vaccination.vaccinationDate != null) {
                          _navigateToDetailVaccination(context, vaccination);
                          return;
                        }
                        _navigateToAddVaccine(context, vaccination);
                      },
                      vaccinationSchedule: vaccination.vaccinationSchedule,
                      vaccineName: vaccination.vaccineName,
                      vaccinationDate: vaccination.vaccinationDate,
                      onDetailTap: () async {
                        await _vaccineStore
                            .setVaccineId(vaccination.vaccine ?? 0);
                        _vaccineStore.setVaccination(vaccination);
                        _showDetailModal(context).then((value) =>
                            _vaccineStore.getRegisteredVaccine(
                                _childrenStore.selectedChildrenId));
                      },
                      isDetail: vaccination.vaccine != null,
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

  Widget _buildSearchField() {
    return Observer(builder: (context) {
      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).pushNamed(Routes.search_vaccination);
          if (!_vaccineStore.loading) {
            if (_childrenStore.selectedChildrenId == 0) {
              _vaccineStore.getUnregisteredVaccine();
            } else {
              _vaccineStore
                  .getRegisteredVaccine(_childrenStore.selectedChildrenId);
            }
            _vaccineStore.dispose();
            _vaccineStore.clearInput();
          }
        },
        child: TextFieldWidget(
          padding: const EdgeInsets.all(16),
          hint: "Cari berdasarkan merk, fungsi, penyakit",
          errorText: null,
          inputAction: TextInputAction.search,
          textController: _searchController,
          prefixIcon: IconlyLight.search,
          fillColor: Colors.white,
          enabled: false,
        ),
      );
    });
  }

  Widget _buildAgeSelector() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 8),
      scrollDirection: Axis.horizontal,
      child: Observer(builder: (context) {
        return Row(
            children: _vaccineStore.listVaccinePeriode.map((e) {
          return SmallChipWidget(
            text: e.periodeTitle,
            selected: e.periodeId == _vaccineStore.selectedPeriodeIndex,
            onSelected: (p0) {
              _vaccineStore.setPeriode(e.periodeId);
              if (_childrenStore.selectedChildrenId == 0) {
                _vaccineStore.getUnregisteredVaccine();
              } else {
                _vaccineStore
                    .getRegisteredVaccine(_childrenStore.selectedChildrenId);
              }
            },
          );
        }).toList());
      }),
    );
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
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
    }
  }

  Container _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xff7AD0E2),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          tr("vaccine_header"),
          style: TextStyle(
            color: Colors.white,
            fontFamily: FontFamily.avenirLTStd,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          tr("vaccine_subheader"),
          style: TextStyle(
            color: Colors.white,
            fontFamily: FontFamily.avenirLTStd,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ]),
    );
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
        context,
        tr("dialog_success"),
        tr("dialog_success_profile",
            args: [WordingUtils.genderGreeting(_userStore.gender)]),
      ).then((value) {
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

  Future<dynamic> _showDetailModal(BuildContext context) {
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
