import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/growth/growth_store.dart';
import 'package:grouu/ui/register/styles/register_styles.dart';
import 'package:grouu/ui/register/widgets/app_bar_register.dart';
import 'package:grouu/ui/register/widgets/register_bg.dart';
import 'package:grouu/ui/register/widgets/register_content_container.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../widgets/show_error_modal.dart';

class GrowthInfo extends StatefulWidget {
  GrowthInfo({Key? key}) : super(key: key);

  @override
  State<GrowthInfo> createState() => _GrowthInfoState();
}

class _GrowthInfoState extends State<GrowthInfo> {
  TextEditingController _bodyHeightController = TextEditingController();

  TextEditingController _bodyWeightController = TextEditingController();

  TextEditingController _headCircumferenceController = TextEditingController();

  TextEditingController _lastMeasurementController = TextEditingController();

  final ChildrenStore _childrenStore = getIt<ChildrenStore>();
  final GrowthStore _store = getIt<GrowthStore>();

  FocusNode _weightFocusNode = FocusNode();
  FocusNode _headFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HexColor.fromHex("#FFFFFF"),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  RegisterGradientBackground(),
                  RegisterContentContainer(
                      appBar: AppBarRegister(onSkip: () => onSkip()),
                      child: _buildRegisterContent()),
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
                  )
                ],
              ),
            ),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Column _buildRegisterContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildRegisterHeader(),
        _buildHeightField(),
        _buildWeightField(),
        _buildHeadCircumference(),
        _buildDatePickerField(),
      ],
    );
  }

  Column _buildRegisterHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.0),
        Text("Step 3 of 4", style: RegisterStyles.textSmall),
        Text("Growth Info", style: RegisterStyles.title),
        SizedBox(height: 5.0),
        Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
            style: RegisterStyles.textSmall),
      ],
    );
  }

  Widget _buildHeightField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Tinggi Badan",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.number,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          textController: _bodyHeightController,
          errorText: _store.growthErrorStore.height,
          onChanged: (value) {
            _store.setHeight(double.parse(_bodyHeightController.text));
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_weightFocusNode);
          },
          suffixWidget: TextButton(
              child: Text("cm", style: RegisterStyles.textMedium),
              onPressed: () {}),
        );
      },
    );
  }

  Widget _buildWeightField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Berat Badan",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.number,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          textController: _bodyWeightController,
          errorText: _store.growthErrorStore.weight,
          focusNode: _weightFocusNode,
          onChanged: (value) {
            _store.setWeight(double.parse(_bodyWeightController.text));
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_headFocusNode);
          },
          suffixWidget: TextButton(
              child: Text("kg", style: RegisterStyles.textMedium),
              onPressed: () {}),
        );
      },
    );
  }

  Widget _buildHeadCircumference() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Lingkar Kepala",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.number,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          textController: _headCircumferenceController,
          focusNode: _headFocusNode,
          errorText: _store.growthErrorStore.headCircumference,
          onChanged: (value) {
            _store.setHeadCircumreference(
                double.parse(_headCircumferenceController.text));
          },
          suffixWidget: TextButton(
              child: Text("cm", style: RegisterStyles.textMedium),
              onPressed: () {}),
        );
      },
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
                _store.setMeasurementDate(value);
                _lastMeasurementController.text =
                    DateFormat("d MMMM yyyy").format(value);
              }
            });
          },
          child: TextFieldWidget(
            hint: "Tanggal Pengukuran",
            hintColor: HexColor.fromHex("#7B7B7B"),
            icon: IconlyBold.calendar,
            enabled: false,
            inputType: TextInputType.datetime,
            padding: EdgeInsets.only(top: 16.0),
            inputAction: TextInputAction.next,
            errorText: _store.growthErrorStore.measurementDate,
            textController: _lastMeasurementController,
          ),
        );
      },
    );
  }

  Widget _buildContinueButton() {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: RoundedButtonWidget(
          isLoading: _store.loading,
          buttonText: "Selanjutnya",
          onPressed: () async {
            print("save");
            if (_childrenStore.selectedChildrenId != 0) {
              if (_store.canAddGrowth) {
                _store.addGrowth(_childrenStore.selectedChildrenId);
              } else {
                _showErrorMessage("Harap lengkapi data");
              }
            }
          },
        ),
      );
    });
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushReplacementNamed(Routes.register_preference);
      _store.dispose();
    });
    return Container();
  }

  void onSkip() {
    Navigator.of(context).pushNamed(Routes.register_preference);
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        showErrorModal(context, "Error", message);
      });
    }

    return SizedBox.shrink();
  }
}
