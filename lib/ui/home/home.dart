import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/stores/home/home_store.dart';
import 'package:grouu/ui/articles/articles.dart';
import 'package:grouu/ui/ecommerce/ecommerce_list.dart';
import 'package:grouu/ui/home/bottom_navbar.dart';
import 'package:grouu/ui/home/home_body.dart';
import 'package:grouu/ui/milestones/milestone_screen.dart';
import 'package:grouu/ui/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:grouu/utils/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserStore _store = getIt<UserStore>();

  final HomeStore _homeStore = getIt<HomeStore>();
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeShowcaseBody(),
    EcommerceList(),
    MilestoneScreen(),
    ArticlesScreen(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_homeStore.currentHomeIndex != 0) {
          _homeStore.setCurrentHomeIndex(0);
          return false;
        } else {
          // Navigator.of(context).pop();
          return true;
        }
      },
      child: Material(
        child: Observer(
          builder: (BuildContext context) {
            return Scaffold(
              body: _widgetOptions[_homeStore.currentHomeIndex],
              bottomNavigationBar: Observer(builder: (context) {
                return BottomNavbar(
                  onTap: ((index) {
                    if (!_store.isLoggedIn && index == 4) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.onboarding, (Route<dynamic> route) => false,
                          arguments: true);
                      return;
                    }
                    _homeStore.setCurrentHomeIndex(index);
                  }),
                  pageIndex: _homeStore.currentHomeIndex,
                  isLoggedIn: _store.isLoggedIn,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
