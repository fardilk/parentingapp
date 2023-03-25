import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/error_message_widget.dart';
import 'package:grouu/widgets/textfield_widget.dart';

import '../../constants/font_family.dart';
import '../../di/components/service_locator.dart';
import '../../stores/form/form_store.dart';
import '../../utils/device/device_utils.dart';
import '../../widgets/rounded_button_widget.dart';

class CreatePasswordScreen extends StatefulWidget {
  @override
  State<CreatePasswordScreen> createState() => CreatePasswordScreenState();
}

class CreatePasswordScreenState extends State<CreatePasswordScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final _store = getIt<FormStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext rootContext) {
    return _buildCreatePasswordWidget();
  }

  _buildCreatePasswordWidget() {
    return Material(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text('Batalkan ?'),
                    actions: <Widget>[
                      CupertinoButton(
                        child: Text('Yes'),
                        onPressed: () {
                          shouldClose = true;
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: Text('No'),
                        onPressed: () {
                          shouldClose = false;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
          return shouldClose;
        },
        child: _buildCreatePasswordNavigator(),
      ),
    );
  }

  Navigator _buildCreatePasswordNavigator() {
    return Navigator(
      onGenerateRoute: (_) => CupertinoPageRoute(
        builder: ((context2) => Builder(
              builder: ((context) => CupertinoPageScaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 28.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _buildModalHeader(),
                            _buildCreatePasswordHeader(),
                            _buildCreatePasswordForm(),
                            Spacer(flex: 1),
                            _buildCreatePasswordSubmit(),
                          ]),
                    ),
                  )),
            )),
      ),
    );
  }

  Observer _buildCreatePasswordSubmit() {
    return Observer(
      builder: (BuildContext context) {
        return RoundedButtonWidget(
          buttonText: "Simpan",
          textColor: Colors.white,
          isLoading: _store.loadingFuture,
          onPressed: () async {
            if (_store.canCreatePassword) {
              DeviceUtils.hideKeyboard(context);
              _store.createPassword(context);
            } else {
              showErrorMessage(context, 'Password requirement not fulfilled.');
            }
          },
        );
      },
    );
  }

  Widget _buildCreatePasswordForm() {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Observer(
          builder: ((context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFieldWidget(
                  isIcon: false,
                  isObscure: true,
                  hint: tr('login_et_user_password'),
                  hintColor: HexColor.fromHex("#7B7B7B"),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  onChanged: (value) {
                    _store.setPassword(_newPasswordController.text);
                  },
                  errorText: _store.formErrorStore.password,
                  textController: _newPasswordController),
            );
          }),
        ),
        Observer(
          builder: ((context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFieldWidget(
                  isIcon: false,
                  isObscure: true,
                  hint: tr('login_et_confirm_user_password'),
                  hintColor: HexColor.fromHex("#7B7B7B"),
                  focusNode: _passwordFocusNode,
                  onChanged: (value) {
                    _store.setConfirmPassword(_confirmPasswordController.text);
                  },
                  errorText: _store.formErrorStore.confirmPassword,
                  textController: _confirmPasswordController),
            );
          }),
        ),
      ],
    );
  }

  Column _buildCreatePasswordHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            tr('create_password_title'),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: HexColor.fromHex("#004D55"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            tr('create_password_subtitle'),
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: HexColor.fromHex("#7B7B7B"),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModalHeader() {
    return Center(
      child: Column(
        children: [
          Container(
              height: 6.0,
              width: 96.0,
              decoration: BoxDecoration(
                  color: HexColor.fromHex("#D9D9D9"),
                  borderRadius: BorderRadius.circular(20.0))),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
