import 'package:flutter/material.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/growth/growth_store.dart';
import 'package:grouu/stores/preference/preference_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/register/styles/register_styles.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/widgets/outline_rounded_button_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/components/service_locator.dart';

class ProfileLogoutWidget extends StatefulWidget {
  ProfileLogoutWidget({Key? key}) : super(key: key);

  @override
  State<ProfileLogoutWidget> createState() => _ProfileLogoutWidgetState();
}

class _ProfileLogoutWidgetState extends State<ProfileLogoutWidget> {
  final UserStore _userStore = getIt<UserStore>();

  final ChildrenStore _childrenStore = getIt<ChildrenStore>();

  final PreferenceStore _preferenceStore = getIt<PreferenceStore>();

  final GrowthStore _growthStore = getIt<GrowthStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).copyWith().size.height * 0.25,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text("Log Out", style: RegisterStyles.title),
            ),
            Center(
              child: Text("Yakin ingin keluar dari aplikasi?",
                  textAlign: TextAlign.center,
                  style: RegisterStyles.textMedium),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlineRoundedButtonWidget(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      buttonText: 'Batal'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RoundedButtonWidget(
                    buttonText: "Yakin",
                    buttonColor: Color(0xffDC3434),
                    textColor: Colors.white,
                    onPressed: () async {
                      SharedPreferences.getInstance().then((preference) {
                        _userStore.logout();
                        _childrenStore.logout();
                        _growthStore.logout();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.splash, (Route<dynamic> route) => false);
                      });
                    },
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
