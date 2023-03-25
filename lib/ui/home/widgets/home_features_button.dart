import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeFeatureButton extends StatelessWidget {
  final String featureName;
  final String iconAsset;
  final String showcaseWording;
  final GlobalKey iconKey;
  final int featureIndex;
  final int maxFeatures = 5;
  final Function() onTap;

  const HomeFeatureButton({
    super.key,
    required this.featureName,
    required this.iconAsset,
    required this.iconKey,
    required this.featureIndex,
    required this.showcaseWording,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Showcase.withWidget(
          disableMovingAnimation: true,
          key: iconKey,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          targetBorderRadius: BorderRadius.circular(24.0),
          container: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: _showcaseCard(context),
          ),
          child: _featureButton(),
        ),
        _featureLabel()
      ],
    );
  }

  Container _featureLabel() {
    return Container(
      constraints: BoxConstraints(maxWidth: 75),
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        featureName,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: TextStyle(
          fontSize: 10.0,
          fontFamily: FontFamily.avenirLTStd,
          color: Color(0xFF3E3C3C),
          fontWeight: FontWeight.bold,
          height: 1.3,
        ),
      ),
    );
  }

  ElevatedButton _featureButton() {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(12.0),
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0))),
      child: Image.asset(
        iconAsset,
        height: 48.0,
        width: 48.0,
      ),
    );
  }

  Card _showcaseCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.only(
          top: 24,
          left: 20,
          right: 20,
          bottom: 18,
        ),
        width: MediaQuery.of(context).size.width - 30,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                showcaseWording,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF3E3C3C),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildPageIndicator(),
                  ),
                  _skipButton(context),
                  _prevButton(context),
                  SizedBox(width: 8),
                  _nextButton(context),
                  _doneButton(context),
                ],
              )
            ]),
      ),
    );
  }

  Visibility _doneButton(BuildContext context) {
    return Visibility(
      visible: featureIndex == maxFeatures - 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Color(0xFF44BED5),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          maximumSize: Size.fromHeight(24),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(25),
          ),
        ),
        onPressed: (() {
          ShowCaseWidget.of(context).completed(iconKey);
        }),
        child: Text(
          "Selesai",
          style: Theme.of(context).textTheme.button!.copyWith(
              fontWeight: FontWeight.w400, color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  Visibility _nextButton(BuildContext context) {
    return Visibility(
      visible: featureIndex != maxFeatures - 1,
      child: InkWell(
          onTap: () {
            ShowCaseWidget.of(context).next();
          },
          child: Image.asset(
            "assets/icons/icon_right.png",
            height: 24,
            width: 24,
          )),
    );
  }

  Visibility _prevButton(BuildContext context) {
    return Visibility(
      visible: featureIndex != 0,
      child: InkWell(
          onTap: () {
            ShowCaseWidget.of(context).previous();
          },
          child: Image.asset(
            "assets/icons/icon_left.png",
            height: 24,
            width: 24,
          )),
    );
  }

  TextButton _skipButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        ShowCaseWidget.of(context).dismiss();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        "Lewati",
        style: TextStyle(
          fontFamily: FontFamily.avenirLTStd,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }

  Row _buildPageIndicator() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(maxFeatures, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: AnimatedSize(
              duration: Duration(milliseconds: 500),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                    width: featureIndex == index ? 16 : 8,
                    height: 8,
                    child: ColoredBox(
                      color: featureIndex == index
                          ? Color(0xFF13B2CC)
                          : Color(0xFFAEE3EE),
                    )),
              ),
            ),
          );
        }));
  }
}
