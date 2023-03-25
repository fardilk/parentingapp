import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/widgets/show_error_modal.dart';
import 'package:pinput/pinput.dart';

import '../../constants/font_family.dart';
import '../../di/components/service_locator.dart';
import '../../stores/form/form_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../utils/device/device_utils.dart';
import '../../utils/ui/color.dart';
import '../../widgets/error_message_widget.dart';
import '../../widgets/rounded_button_widget.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  //text controllers:-----------------------------------------------------------
  final pinController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final _store = getIt<FormStore>();

  late Timer _timer;
  int _timerCount = 60;

  @override
  void initState() {
    _store.disposeOtp();
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
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
          isLoading: _store.loadingFuture,
          onPressed: () async {
            if (_store.canOtp) {
              DeviceUtils.hideKeyboard(context);
              _store.submitOtp(context);
            } else {
              DeviceUtils.hideKeyboard(context);

              showErrorModal(context, 'Error', 'Please fill OTP in all fields');
            }
          },
        );
      },
    );
  }

  Padding _buildOtpResend() {
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
        _timerCount == 0
            ? TextButton(
                onPressed: () {
                  setState(() {
                    _timerCount = 60;

                    _store.forgotPassword(context, true);
                  });
                },
                child: Text(
                  "Resend",
                  style: TextStyle(
                    fontFamily: FontFamily.avenirLTStd,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              )
            : Text(
                " Resend after $_timerCount second(s)",
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
      ]),
    );
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
          onChanged: (value) {
            _store.setOtp(value);
          },
          onCompleted: (value) {
            _store.setOtp(value);
            DeviceUtils.hideKeyboard(context);
            _store.submitOtp(context);
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

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timerCount == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _timerCount--;
          });
        }
      },
    );
  }
}
