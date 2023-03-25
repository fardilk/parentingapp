import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/repository/auth_repository.dart';
import 'package:grouu/data/repository/repository.dart';
import 'package:grouu/data/sharedpref/constants/preferences.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/home/home_store.dart';
import 'package:grouu/ui/register/styles/register_styles.dart';
import 'package:grouu/ui/register/widgets/otp_failed.dart';
import 'package:grouu/ui/register/widgets/otp_register_screen.dart';
import 'package:grouu/ui/register/widgets/otp_success.dart';
import 'package:grouu/ui/register/widgets/register_bg.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/stores/form/form_store.dart';
import 'package:grouu/stores/theme/theme_store.dart';
import 'package:grouu/utils/device/device_utils.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/show_error_modal.dart';
import '../articles/articles_detail.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final _homeStore = getIt<HomeStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _phoneNumberFocusNode;

  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPasswordFocusNode;

  //stores:---------------------------------------------------------------------
  final _store = FormStore(getIt<Repository>(), getIt<AuthRepository>());
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      color: HexColor.fromHex("#FFFFFF"),
      child: Stack(
        children: <Widget>[
          RegisterGradientBackground(),
          _buildRegisterForm(),
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
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildRoundedTopRight(),
              ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildRegisterHeader(),
                      _buildUserEmailField(),
                      _buildPasswordField(),
                      _buildSignUpButton(),
                      _buildTermsConditionCheckbox(),
                      //_buildSignUpASocial(),
                      _buildLoginButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildRoundedTopRight() {
    return Container(
      height: 49,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(IconlyLight.arrow_left_2, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Image.asset("assets/images/reg_appbar_icon.png"),
      actions: [
        TextButton(
            onPressed: () {
              _homeStore.setCurrentHomeIndex(0);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.home, (Route<dynamic> route) => false);
            },
            child: Text(tr('register_skip'),
                style: TextStyle(color: Colors.white)))
      ],
    );
  }

  Column _buildRegisterHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 37.0),
        Text(tr('login_sign_up'), style: RegisterStyles.title),
        SizedBox(
          height: 5.0,
        ),
        Text(tr('register_signup_title'),
            style: RegisterStyles.textMediumRegular),
      ],
    );
  }

  Widget _buildUserEmailField() {
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
            FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
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
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
          },
          onChanged: (value) {
            _store.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RoundedButtonWidget(
        buttonText: "Daftar",
        onPressed: () async {
          if (isChecked) {
            if (_store.canRegister) {
              DeviceUtils.hideKeyboard(context);
              _store.register();
            }
          } else {
            showErrorModal(context, "Error",
                "Harap menyetujui Terms and Condition sebelum mendaftarkan akun baru");
          }
        },
      ),
    );
  }

  Center _buildSignUpASocial() {
    return Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            tr('register_social_wording'),
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
                    _showErrorMessage('Not Implemented');
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
                  _showErrorMessage('Not Implemented');
                  //TODO : Implement Facebook login
                },
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget _buildTermsConditionCheckbox() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              side: BorderSide(
                width: 1,
                color: HexColor.fromHex("#E1E1E1"),
              ),
              activeColor: Color(0xff44BED5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Dengan mendaftar, saya menyetujui',
                    style: RegisterStyles.textMediumRegular,
                  ),
                  TextSpan(
                    text: ' Terms and Condition',
                    style: RegisterStyles.textMediumRegular.copyWith(
                        color: Color(0xff00A5C3), fontWeight: FontWeight.w800),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlesDetail(
                              slug: "",
                              detailType: DetailType.TermsCondition,
                            ),
                          ),
                        );
                      },
                  ),
                  TextSpan(
                    text: ' yang berlaku',
                    style: RegisterStyles.textMediumRegular,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          tr('register_asking_account'),
          style: RegisterStyles.textMediumRegular
              .copyWith(color: Color(0xff242424)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            tr('login_button'),
          ),
        ),
      ]),
    );
  }

  Widget navigate(BuildContext context) {
    _homeStore.setCurrentHomeIndex(0);
    Future.delayed(Duration(milliseconds: 0), () {
      _store.dispose();
      _showOtpModal(context, _store.currentUserId);
    });

    return Container();
  }

  Widget _registerSuccess(BuildContext context, int currentUserId) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(Preferences.current_user_id, currentUserId);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
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

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    // _passwordFocusNode.dispose();
    super.dispose();
  }

  _showOtpModal(BuildContext context, currentUserId) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(Preferences.current_user_id, currentUserId);
    });

    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        isDismissible: false,
        builder: (_) {
          return LayoutBuilder(builder: (context, _) {
            //<----- very important use this context
            return AnimatedPadding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                duration: Duration(milliseconds: 150),
                curve: Curves.easeOut,
                child: Container(
                  constraints: BoxConstraints(maxHeight: 500, minHeight: 150),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 28.0),
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.50,
                      child: OtpRegisterScreen(
                        onFailed: () => _showFailedModal(context),
                        onSuccess: () => _showSuccessModal(context),
                      )),
                ));
          });
        }).then((value) => _registerSuccess(context, _store.currentUserId));
  }

  _showSuccessModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return Observer(builder: (context) {
            Timer(Duration(seconds: 5),
                () => _registerSuccess(context, _store.currentUserId));
            return OtpSuccessModal(
                onTapSuccess: () =>
                    _registerSuccess(context, _store.currentUserId));
          });
        });
  }

  _showFailedModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          Timer(Duration(seconds: 5), () => Navigator.of(context).pop());
          return OtpFailedModal();
        });
  }
}
