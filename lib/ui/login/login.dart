import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sharedpref/constants/preferences.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/ui/login/forgot_password.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/stores/form/form_store.dart';
import 'package:grouu/utils/device/device_utils.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/error_message_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final _store = getIt<FormStore>();

  @override
  void initState() {
    super.initState();
    _store.setupValidations();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext parentContext) {
    return _buildBody(parentContext);
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody(BuildContext parentContext) {
    return Stack(
      children: <Widget>[
        _buildLoginForm(),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.90,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        child: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  //TODO: Using API Call if ready
                  'assets/images/register_banner.png',
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildLoginHeader(),
                      _buildErrorText(),
                      _buildUserIdField(),
                      _buildPasswordField(),
                      _buildForgotPasswordButton(),
                      _buildSignInButton(),
                      //_buildSignInASocial(),
                      _buildRegisterButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildLoginHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 37.0),
        Text(
          tr('login_welcome'),
          style: TextStyle(
            fontFamily: FontFamily.avenirLTStd,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: HexColor.fromHex("#004D55"),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          tr('login_welcome_subtitle'),
          style: TextStyle(
            fontFamily: FontFamily.avenirLTStd,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: HexColor.fromHex("#7B7B7B"),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorText() {
    return Observer(
      builder: (context) {
        return _store.success
            ? navigate(context)
            : _showErrorMessage(
                context, _store.formErrorStore.errorMessage ?? "");
      },
    );
  }

  _showErrorMessage(BuildContext context, String message) {
    if (message.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xffFFEFF3),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              message,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: HexColor.fromHex("#DE004F"),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: tr('login_et_user_email'),
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.emailAddress,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _store.formErrorStore.userEmail,
          textController: _userEmailController,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: tr('login_et_user_password'),
          hintColor: HexColor.fromHex("#7B7B7B"),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          isIcon: false,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _store.formErrorStore.password,
          onChanged: (value) {
            _store.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: FractionalOffset.centerRight,
        child: TextButton(
          onPressed: () {
            _showForgotModal(context);
          },
          child: Text(
            "Lupa Password?",
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Observer(
        builder: (BuildContext context) {
          return RoundedButtonWidget(
            buttonText: tr('login_btn_sign_in'),
            textColor: Colors.white,
            isLoading: _store.loadingFuture,
            onPressed: () async {
              if (_store.canLogin) {
                DeviceUtils.hideKeyboard(context);
                _store.login();
              } else {
                _showErrorMessage(context, 'Please fill in all fields');
              }
            },
          );
        },
      ),
    );
  }

  Center _buildSignInASocial() {
    return Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "atau masuk dengan",
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: HexColor.fromHex("#3E3C3C"),
              height: 1.5,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RoundedButtonWidget(
                icon: Image.asset("assets/icons/icon_google.png"),
                buttonText: "Google",
                buttonColor: HexColor.fromHex("#f4f4f4"),
                textColor: HexColor.fromHex("#3E3C3C"),
                onPressed: () async {
                  if (_store.canLogin) {
                    DeviceUtils.hideKeyboard(context);
                    _store.login();
                  } else {
                    showErrorMessage(context, 'Not Implemented');
                    //TODO : Implement Firebase or Google Login
                  }
                },
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: RoundedButtonWidget(
                icon: Image.asset("assets/icons/icon_facebook.png"),
                buttonText: "Facebook",
                buttonColor: HexColor.fromHex("#f4f4f4"),
                textColor: HexColor.fromHex("#3E3C3C"),
                onPressed: () async {
                  showErrorMessage(context, 'Not Implemented');
                  //TODO : Implement Facebook login
                },
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Belum punya akun? ",
          style: TextStyle(
            fontFamily: FontFamily.avenirLTStd,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: HexColor.fromHex("#3E3C3C"),
            height: 1.5,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.register);
            _store.disposeLoginField();
            _passwordController.text = "";
            _userEmailController.text = "";
          },
          child: Text(
            "Daftar Sekarang",
          ),
        ),
      ]),
    );
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(seconds: 0), () async {
      await Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });
    _store.dispose();
    return Container();
  }

  // General Methods:-----------------------------------------------------------

  _showForgotModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return ForgotPasswordScreen();
        });
  }

  Future<bool> getDeviceManufacturer() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var isVivo = androidInfo.manufacturer.toLowerCase().contains("vivo") ||
        androidInfo.brand.toLowerCase().contains("vivo");
    return isVivo;
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _store.disposeLoginField();
    // _passwordFocusNode.dispose();
    super.dispose();
  }
}
