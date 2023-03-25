import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/font_family.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xFF7ad0e2),
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(IconlyLight.arrow_left_2, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(tr("help_and_support"),
          style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
    );
  }

  _buildBody() {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr("help_and_support"),
              style: TextStyle(
                  fontFamily: FontFamily.candyCake,
                  fontSize: 20,
                  color: Color(0xff3E3C3C),
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 12),
            Text(
              tr("help_and_support_subtitle"),
              style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  color: Color(0xff242424),
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            SupportButton(
              text: tr("help_and_support_cs"),
              iconAsset: "assets/icons/icon_cs.png",
              onTap: () async {
                final url =
                    "https://api.whatsapp.com/send/?phone=628119105089&text=Hallo&type=phone_number&app_absent=0";
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            SupportButton(
              text: tr("help_and_support_email"),
              iconAsset: "assets/icons/icon_email.png",
              onTap: () async {
                final url = "mailto:help@grouu.id?subject=Tracker%20App";
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SupportButton extends StatelessWidget {
  final String iconAsset;
  final String text;
  final Function() onTap;
  const SupportButton({
    Key? key,
    required this.iconAsset,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffEEFBFE),
            padding: EdgeInsets.all(16),
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(16.0))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              iconAsset,
              width: 30,
              height: 30,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: FontFamily.avenirLTStd,
                    fontSize: 14,
                    color: Color(0xff006F7F),
                    fontWeight: FontWeight.w700),
              ),
            ),
            Icon(IconlyLight.arrow_right_2, color: Color(0xff006F7F)),
          ],
        ),
      ),
    );
  }
}
