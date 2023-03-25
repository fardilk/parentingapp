import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/vaccine/vaccine_store.dart';
import 'package:grouu/widgets/action_success_modal.dart';

import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../widgets/show_error_modal.dart';
import 'widget/detail_vaccine_widget.dart';

class AddVaccinationScreen extends StatefulWidget {
  const AddVaccinationScreen({super.key});

  @override
  State<AddVaccinationScreen> createState() => _AddVaccinationScreenState();
}

class _AddVaccinationScreenState extends State<AddVaccinationScreen> {
  TextEditingController _vaccinationDateController = TextEditingController();
  TextEditingController _vaccineBrandController = TextEditingController();
  TextEditingController _vaccineNameController = TextEditingController();
  TextEditingController _locationNameController = TextEditingController();
  TextEditingController _doctorNameController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _batchNumberController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  FocusNode _vaccineBrandFocus = FocusNode();
  FocusNode _locationNameFocus = FocusNode();
  FocusNode _doctorNameFocus = FocusNode();
  FocusNode _batchNumberFocus = FocusNode();
  FocusNode _notesFocus = FocusNode();

  ChildrenStore _childrenStore = getIt<ChildrenStore>();
  VaccineStore _vaccineStore = getIt<VaccineStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fullNameController.text =
        "${_childrenStore.firstName} ${_childrenStore.lastName}";
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _vaccinationDateController.dispose();
    _vaccineBrandController.dispose();
    _vaccineNameController.dispose();
    _locationNameController.dispose();
    _batchNumberController.dispose();
    _doctorNameController.dispose();
    _notesController.dispose();

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
                Text(
                  "Informasi Vaksinasi",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.avenirLTStd),
                ),
                _buildFullNameField(),
                _buildVaccineNameFIeld(),
                _buildDatePickerField(),
                _buildVaccineBrandField(),
                SizedBox(height: 16),
                Text(
                  "Informasi Tambahan",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.avenirLTStd),
                ),
                _buildLocationNameField(),
                _buildDoctorNameField(),
                _buildBatchNumberField(),
                _buildNotesField(),
                SizedBox(height: 16),
                _buildHowToDeal()
              ]),
              _buildSaveButton()
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
    return BackAppBar(
      title: _vaccineStore.vaccineId == 0
          ? Text("New Vaccine")
          : Text(_vaccineStore.vaccineName),
      actions: [
        Observer(
          builder: (context) {
            if (_vaccineStore.vaccineId != 0) {
              return TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  onPressed: () {
                    _showDetailModal(context);
                  },
                  child: Text("Detail Info"));
            }
            return SizedBox();
          },
        )
      ],
    );
  }

  Widget _buildDatePickerField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ).then((value) {
              if (value != null) {
                _vaccineStore.setVaccinationDate(value);
                _vaccinationDateController.text =
                    DateFormat("d MMMM yyyy").format(value);
              }
            });
          },
          child: TextFieldWidget(
            hint: "Tanggal Vaksin",
            hintColor: HexColor.fromHex("#7B7B7B"),
            icon: IconlyBold.calendar,
            enabled: false,
            inputType: TextInputType.phone,
            padding: EdgeInsets.only(top: 16.0),
            inputAction: TextInputAction.next,
            onFieldSubmitted: (value) {
              // FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            errorText: null,
            textController: _vaccinationDateController,
          ),
        );
      },
    );
  }

  Widget _buildFullNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          fillColor: Color(0xffE1E1E1),
          icon: IconlyLight.arrow_down_2,
          enabled: false,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            // FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: null,
          textController: _fullNameController,
        );
      },
    );
  }

  Widget _buildVaccineNameFIeld() {
    return Observer(
      builder: (context) {
        if (_vaccineStore.vaccineId != 0) {
          return SizedBox();
        }
        return TextFieldWidget(
          isIcon: false,
          hint: "Nama Vaksin",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.name,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          textController: _vaccineNameController,
          onChanged: (value) {
            _vaccineStore.setVaccineName(_vaccineNameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_vaccineBrandFocus);
          },
          errorText: null,
        );
      },
    );
  }

  Widget _buildVaccineBrandField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Merek Vaksin",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.name,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          focusNode: _vaccineBrandFocus,
          textController: _vaccineBrandController,
          onChanged: (value) {
            _vaccineStore.setVaccineBrand(_vaccineBrandController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_locationNameFocus);
          },
          errorText: null,
        );
      },
    );
  }

  Widget _buildLocationNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Lokasi (Opsional)",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.name,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          focusNode: _locationNameFocus,
          textController: _locationNameController,
          errorText: null,
          onChanged: (value) {
            _vaccineStore.setLocationName(_locationNameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_doctorNameFocus);
          },
        );
      },
    );
  }

  Widget _buildDoctorNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Nama Tenaga Kesehatan (Opsional)",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.name,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          focusNode: _doctorNameFocus,
          textController: _doctorNameController,
          errorText: null,
          onChanged: (value) {
            _vaccineStore.setDoctorName(_doctorNameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_batchNumberFocus);
          },
        );
      },
    );
  }

  Widget _buildBatchNumberField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "No. Batch Vaksin (Opsional)",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.name,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          focusNode: _batchNumberFocus,
          textController: _batchNumberController,
          errorText: null,
          onChanged: (value) {
            _vaccineStore.setBatchNumber(_batchNumberController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_notesFocus);
          },
        );
      },
    );
  }

  Widget _buildNotesField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Catatan Tambahan (Opsional)",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.name,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          focusNode: _notesFocus,
          textController: _notesController,
          errorText: null,
          onChanged: (value) {
            _vaccineStore.setNotes(_notesController.text);
          },
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return Observer(builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: RoundedButtonWidget(
            isLoading: _vaccineStore.loading,
            buttonText: "Simpan",
            onPressed: () async {
              if (!_vaccineStore.canAddVaccine) {
                _showErrorMessage("Harap lengkapi data");
                return;
              }

              if (_vaccineStore.vaccineId != 0) {
                _vaccineStore.updateVaccine();
              } else {
                _vaccineStore.addVaccination(_childrenStore.selectedChildrenId,
                    _childrenStore.birthday!);
              }
            }),
      );
    });
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoundedTop(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            )
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
    Timer(Duration(seconds: 5), () => Navigator.of(context).pop());
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: false,
        isDismissible: false,
        builder: (BuildContext context) {
          return ActionSuccessModal(
            description:
                "Data vaksin telah berhasil disimpan dalam database kamu",
            title: "Input Vaksin Berhasil!",
          );
        });
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
