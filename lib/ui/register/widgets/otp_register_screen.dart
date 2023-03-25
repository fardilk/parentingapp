import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/utils/device/device_utils.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:pinput/pinput.dart';

class OtpRegisterScreen extends StatefulWidget {
  const OtpRegisterScreen({
    super.key,
    required this.onSuccess,
    required this.onFailed,
  });

  @override
  State<OtpRegisterScreen> createState() => _OtpRegisterScreenState();

  final Function onSuccess;
  final Function onFailed;
}

class _OtpRegisterScreenState extends State<OtpRegisterScreen> {
  //text controllers:-----------------------------------------------------------
  final pinController = TextEditingController();
  final UserStore _userStore = getIt<UserStore>();

  @override
  void initState() {
    super.initState();
    _userStore.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildOtpForm(),
      ],
    );
  }

  _buildOtpForm() {
    return Material(
      color: Colors.white,
      child: WillPopScope(
        onWillPop: () async {
          return await _showBatalkanDialog();
        },
        child: _buildModalNavigator(),
      ),
    );
  }

  Future<bool> _showBatalkanDialog() async {
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
  }

  Navigator _buildModalNavigator() {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
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
                            _buildOtpHeader(),
                            _buildOtpField(),
                            _buildOtpResend(),
                            Spacer(
                              flex: 1,
                            ),
                            _buildOtpSubmit(),
                          ]),
                    ),
                  )),
            )),
      ),
    );
  }

  Center _buildModalHeader() {
    return Center(
      child: Container(
          height: 6.0,
          width: 96.0,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#D9D9D9"),
              borderRadius: BorderRadius.circular(20.0))),
    );
  }

  Widget _buildOtpSubmit() {
    return Observer(
      builder: (BuildContext context) {
        return RoundedButtonWidget(
          buttonText: "Submit",
          textColor: Colors.white,
          onPressed: () async {
            bool verifySuccess =
                await _userStore.verifyEmail(pinController.text);
            if (verifySuccess) {
              DeviceUtils.hideKeyboard(context);
              widget.onSuccess();
              _userStore.checkLogin();
            } else {
              DeviceUtils.hideKeyboard(context);
              widget.onFailed();
            }
          },
        );
      },
    );
  }

  Widget _buildOtpResend() {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            "Didn’t get your OTP?",
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
              if (!_userStore.loading) {
                _userStore.sendVerificationEmail();
              }
            },
            child: Text(
              _userStore.loading ? "Sending ... " : "Resend",
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ]),
      );
    });
  }

  Widget _buildOtpField() {
    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: Theme.of(context).textTheme.bodyText1,
      decoration: BoxDecoration(
        border: Border.all(color: HexColor.fromHex("#E1E1E1")),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Padding(
        padding: const EdgeInsets.only(top: 26.0),
        child: Pinput(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          defaultPinTheme: defaultPinTheme,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          controller: pinController,
          length: 6,
          // onChanged: (value) {
          //   _store.setOtp(value);
          // },
          onCompleted: (value) {
            DeviceUtils.hideKeyboard(context);
          },
        ));
  }

  Column _buildOtpHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            "OTP Verification",
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
            "Please enter your OTP that sent to your registered email",
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
}
