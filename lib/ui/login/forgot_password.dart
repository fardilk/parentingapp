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

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final _store = getIt<FormStore>();

  @override
  void initState() {
    _userEmailController.text = _store.userEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext rootContext) {
    _store.setLoginContext(rootContext);
    return _buildBody();
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildForgotPasswordForm(),
      ],
    );
  }

  _buildForgotPasswordForm() {
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
        child: AnimatedPadding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
          child: Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.50,
            clipBehavior: Clip.hardEdge,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(32.0)),
            child: _buildForgotNavigator(),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotNavigator() {
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
                            Center(
                              child: _buildModalHeader(),
                            ),
                            _buildForgotHeader(),
                            _buildForgotForm(),
                            Spacer(
                              flex: 1,
                            ),
                            _buildForgotSubmit(),
                          ]),
                    ),
                  )),
            )),
      ),
    );
  }

  Observer _buildForgotSubmit() {
    return Observer(
      builder: (BuildContext context) {
        return RoundedButtonWidget(
          buttonText: "Kirim OTP",
          textColor: Colors.white,
          isLoading: _store.loadingFuture,
          onPressed: () async {
            if (_store.canForgetPassword) {
              DeviceUtils.hideKeyboard(context);
              _store.forgotPassword(context, false);
            } else {
              showErrorMessage(context, 'Please fill in all fields');
            }
          },
        );
      },
    );
  }

  Observer _buildForgotForm() {
    return Observer(builder: ((context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 26.0),
        child: TextFieldWidget(
            isIcon: false,
            hint: tr('login_et_user_email'),
            hintColor: HexColor.fromHex("#7B7B7B"),
            inputType: TextInputType.emailAddress,
            onChanged: (value) {
              _store.setUserId(_userEmailController.text);
            },
            errorText: _store.formErrorStore.userEmail,
            textController: _userEmailController),
      );
    }));
  }

  Column _buildForgotHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            tr('forget_password_title'),
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
            tr('forget_password_subtitle'),
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

  Column _buildModalHeader() {
    return Column(
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
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    super.dispose();
  }
}
