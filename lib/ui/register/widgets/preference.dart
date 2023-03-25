import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/preference/preference_store.dart';
import 'package:grouu/ui/register/styles/register_styles.dart';
import 'package:grouu/ui/register/widgets/app_bar_register.dart';
import 'package:grouu/ui/register/widgets/register_bg.dart';
import 'package:grouu/ui/register/widgets/register_content_container.dart';
import 'package:grouu/ui/register/widgets/register_success.dart';

import 'package:grouu/widgets/chip_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../widgets/show_error_modal.dart';

class RegisterPreference extends StatefulWidget {
  RegisterPreference({Key? key}) : super(key: key);

  @override
  State<RegisterPreference> createState() => _RegisterPreferenceState();
}

class _RegisterPreferenceState extends State<RegisterPreference> {
  final PreferenceStore _store = getIt<PreferenceStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_store.loading) {
      _store.getPreferenceByUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
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
                    child: _buildRegisterContent(),
                  ),
                  Observer(
                    builder: (context) {
                      return _store.success
                          ? _navigate(context)
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
        SizedBox(height: 24),
        _buildPreferencePicker()
      ],
    );
  }

  Widget _buildPreferencePicker() {
    return Observer(builder: (context) {
      return Wrap(
        spacing: 8,
        children: _store.listPreferenceItems.map((e) {
          return ChipWidget(
            onSelected: (state) => _store.setPreference(e.id, state),
            text: e.text,
            selected: e.active,
          );
        }).toList(),
      );
    });
  }

  Column _buildRegisterHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.0),
        Text("Step 4 of 4", style: RegisterStyles.textSmall),
        Text("Preference", style: RegisterStyles.title),
        SizedBox(height: 5.0),
        Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
            style: RegisterStyles.textSmall),
      ],
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
            if (_store.preferenceId != 0) {
              _store.updatePreference();
            } else {
              _store.addPreference();
            }
          },
        ),
      );
    });
  }

  Widget _navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _store.dispose();
      _showSuccessModal(context);
    });

    return Container();
  }

  void onSkip() {
    _showSuccessModal(context);
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
          return RegisterSuccess();
        });
  }
}
