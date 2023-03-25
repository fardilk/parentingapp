import 'package:another_flushbar/flushbar_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/preference/preference_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/profile/styles/profile_styles.dart';

import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/chip_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/show_success_modal.dart';

import '../../utils/locale/wording_utils.dart';
import '../../widgets/show_error_modal.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final PreferenceStore _store = getIt<PreferenceStore>();
  final UserStore _userStore = getIt<UserStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_store.loading) {
      _store.getPreferenceByUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppBar(title: Text("Preference")),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [
                Text("Preference", style: ProfileStyles.sectionTitle),
                SizedBox(height: 16),
                _buildPreferencePicker(),
              ]),
              _buildSaveButton()
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

  Widget _buildSaveButton() {
    return Observer(builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: RoundedButtonWidget(
          buttonText: "Simpan",
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
}
