import 'dart:async';

import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sharedpref/constants/preferences.dart';
import 'package:grouu/data/sqlite/service/milestone_service.dart';
import 'package:grouu/data/sqlite/service/vaccine_service.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../stores/growth/growth_store.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GrowthStore _growthStore = getIt<GrowthStore>();
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_splash.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/logogram.png")),
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: Text(
                  "App for Super Parents",
                  style: TextStyle(
                      fontFamily: FontFamily.candyCake,
                      fontSize: 24,
                      color: Color(0xff13B2CC)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    VaccineService vaccineService = VaccineService();
    MilestoneService milestoneService = MilestoneService();
    await vaccineService.initVaccineDetail();
    await milestoneService.initMilestone();
    await _growthStore.getAllGrowthRiskDatas(null);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.onboarding);
    }
  }
}
