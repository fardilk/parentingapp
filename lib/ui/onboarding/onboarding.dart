import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/ui/login/login.dart';
import 'package:grouu/ui/onboarding/model/onboarding_content.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../di/components/service_locator.dart';
import '../../stores/home/home_store.dart';
import '../../utils/routes/routes.dart';

class Onboadring extends StatefulWidget {
  const Onboadring({key});

  @override
  State<Onboadring> createState() => _OnboadringState();
}

class _OnboadringState extends State<Onboadring> {
  final PageController _pageController = PageController();
  final _homeStore = getIt<HomeStore>();

  int _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _homeStore.setCurrentHomeIndex(0);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args = ModalRoute.of(context)!.settings.arguments as bool?;

      if (args == true) {
        _showLoginModal(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: onboardingContents[_page].color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(flex: 1),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.home, (Route<dynamic> route) => false);
              },
              child: Text(
                "Lewati",
                style: TextStyle(color: onboardingContents[_page].darkColor),
              ),
            ),
            Expanded(
              flex: 13,
              child: PageView(
                /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                /// Use [Axis.vertical] to scroll vertically.
                controller: _pageController,
                children: onboardingContents.map((data) {
                  return _buildOnboardingContent(data);
                }).toList(),
                onPageChanged: ((value) {
                  setState(() {
                    _page = value;
                  });
                }),
              ),
            ),
            _buildPageIndicator(),
            Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(208, 44),
                        elevation: 0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        foregroundColor: onboardingContents[_page].darkColor),
                    onPressed: () {
                      _showLoginModal(context);
                    },
                    child: Text("Jelajah Sekarang")),
              ),
            ),
            Spacer(flex: 2)
          ],
        ),
      ),
    );
  }

  _showLoginModal(BuildContext onboardingContext) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        context: onboardingContext,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return LoginScreen();
        });
  }

  Widget _buildOnboardingContent(OnBoardingContent data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(80, 00, 80, 24), child: data.image),
        Text(
          data.title,
          style: TextStyle(
            fontFamily: FontFamily.candyCake,
            fontSize: 44,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                color: data.darkColor,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34.0),
          child: Text(
            data.slug,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF535151),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildPageIndicator() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(onboardingContents.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: AnimatedSize(
              duration: Duration(milliseconds: 500),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                    width: _page == index ? 16 : 8,
                    height: 8,
                    child: ColoredBox(color: Colors.white)),
              ),
            ),
          );
        }));
  }
}
