import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/profile/styles/profile_styles.dart';
import 'package:grouu/ui/profile/widgets/delete_reason_widget.dart';
import 'package:grouu/utils/locale/wording_utils.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/show_success_modal.dart';

import '../../widgets/show_error_modal.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  UserStore _store = getIt<UserStore>();

  bool reason = false;
  List<int> _reasonIds = [];

  void _checkReason(int id) async {
    setState(() {
      if (_reasonIds.contains(id)) {
        _reasonIds.remove(id);
      } else {
        _reasonIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppBar(title: Text("Account Info")),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [
                Center(
                    child:
                        Image.asset("assets/images/delete_account_banner.png")),
                SizedBox(height: 16),
                Text(
                    "Hi ${WordingUtils.genderGreeting(_store.gender)} ${_store.lastName},",
                    style: ProfileStyles.sectionTitle),
                SizedBox(height: 16),
                Text(
                    tr('delete_account_subtitle', namedArgs: {
                      "greeting": WordingUtils.genderGreeting(_store.gender)
                    }),
                    style: ProfileStyles.textMedium),
                SizedBox(height: 16),
                DeleteReasonWidget(
                  child: Text(
                    tr('delete_account_option_rarely',
                        args: [WordingUtils.genderGreeting(_store.gender)]),
                  ),
                  value: _reasonIds.contains(1),
                  onChanged: (_) => _checkReason(1),
                ),
                DeleteReasonWidget(
                  child: Text(
                    tr('delete_account_option_satisfied'),
                  ),
                  value: _reasonIds.contains(2),
                  onChanged: (_) => _checkReason(2),
                ),
                DeleteReasonWidget(
                  child: Text(
                    tr('delete_account_option_account',
                        args: [WordingUtils.genderGreeting(_store.gender)]),
                  ),
                  value: _reasonIds.contains(3),
                  onChanged: (_) => _checkReason(3),
                ),
                DeleteReasonWidget(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: tr('delete_account_option_others'),
                    ),
                  ),
                  value: _reasonIds.contains(4),
                  onChanged: (_) => _checkReason(4),
                ),
                SizedBox(height: 36),
                _buildSaveButton(),
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
                  visible: _store.loading,
                  child: CustomProgressIndicatorWidget());
            },
          )
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Observer(builder: (context) {
      return RoundedButtonWidget(
        buttonText: "Simpan",
        buttonColor: Color(0xffDC3434),
        onPressed: () async {
          _store.deleteAccount();
        },
      );
    });
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
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
      _store.logout();
      showSuccessModal(
              context, "Profile Deleted", "Profile Deleted Successfully")
          .then((value) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.splash, (Route<dynamic> route) => false);
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
