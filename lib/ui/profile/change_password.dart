import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/profile/styles/profile_styles.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/show_success_modal.dart';
import 'package:grouu/widgets/textfield_widget.dart';

import '../../widgets/show_error_modal.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  FocusNode _newPaswordFocus = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  UserStore _userStore = getIt<UserStore>();

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _userStore.dispose();
    // _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppBar(title: Text("Change Password")),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [
                Text("Current Password", style: ProfileStyles.sectionTitle),
                _buildOldPassword(),
                SizedBox(height: 16),
                Text("New Password", style: ProfileStyles.sectionTitle),
                _buildNewPasswordField(),
                _buildConfirmPasswordField(),
              ]),
              _buildSaveButton()
            ],
          ),
          Observer(
            builder: (context) {
              return _userStore.success
                  ? navigate(context)
                  : _showErrorMessage(_userStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                  visible: _userStore.loading,
                  child: CustomProgressIndicatorWidget());
            },
          )
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Observer(builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: RoundedButtonWidget(
            isLoading: _userStore.loading,
            buttonText: "Simpan",
            onPressed: () async {
              if (_userStore.canChangePassword) {
                _userStore.changePassword();
              } else {
                _showErrorMessage("Harap lengkapi data");
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOldPassword() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: "Old Password",
          hintColor: HexColor.fromHex("#7B7B7B"),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          isIcon: false,
          textController: _oldPasswordController,
          errorText: _userStore.userErrorStore.oldPassword,
          onChanged: (value) {
            _userStore.setOldPassword(_oldPasswordController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_newPaswordFocus);
          },
        );
      },
    );
  }

  Widget _buildNewPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: "New Password",
          hintColor: HexColor.fromHex("#7B7B7B"),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          isIcon: false,
          textController: _newPasswordController,
          focusNode: _newPaswordFocus,
          errorText: _userStore.userErrorStore.password,
          onChanged: (value) {
            _userStore.setPassword(_newPasswordController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
          },
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: "Confirmation Password",
          hintColor: HexColor.fromHex("#7B7B7B"),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          isIcon: false,
          textController: _confirmPasswordController,
          focusNode: _confirmPasswordFocusNode,
          errorText: _userStore.userErrorStore.confirmPassword,
          onChanged: (value) {
            _userStore.setConfirmPassword(_confirmPasswordController.text);
          },
        );
      },
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
              context, "Password Changed", "Password Changed Successfully")
          .then((value) {
        Navigator.of(context).pop(true);
        _userStore.dispose();
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
