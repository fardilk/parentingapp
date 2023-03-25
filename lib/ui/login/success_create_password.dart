import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/utils/ui/color.dart';

import '../../constants/font_family.dart';
import '../../di/components/service_locator.dart';
import '../../stores/form/form_store.dart';
import '../../widgets/rounded_button_widget.dart';

class SuccessCreatePassScreen extends StatefulWidget {
  @override
  State<SuccessCreatePassScreen> createState() =>
      SuccessCreatePassScreenState();
}

class SuccessCreatePassScreenState extends State<SuccessCreatePassScreen> {
  //stores:---------------------------------------------------------------------
  final _store = getIt<FormStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext rootContext) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildSuccessCreateWidget(),
      ],
    );
  }

  _buildSuccessCreateWidget() {
    return Material(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: _buildNavigator(),
    );
  }

  Navigator _buildNavigator() {
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
                            _buildSuccessHeader(),
                            Spacer(
                              flex: 1,
                            ),
                            _buildLoginButton(),
                          ]),
                    ),
                  )),
            )),
      ),
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

  Observer _buildLoginButton() {
    return Observer(
      builder: (BuildContext context) {
        return RoundedButtonWidget(
          buttonText: "Login",
          textColor: Colors.white,
          isLoading: _store.loadingFuture,
          onPressed: () async {
            _store.dismissForgotPassModal();
          },
        );
      },
    );
  }

  Column _buildSuccessHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/icon_checkmark.gif",
          width: 127.0,
          height: 127.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            "Password berhasil diubah",
            textAlign: TextAlign.center,
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
            "Your new password has been successfully created. Please try login again using your new password",
            textAlign: TextAlign.center,
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

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }
}
