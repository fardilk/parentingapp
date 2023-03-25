import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/font_family.dart';
import '../../widgets/outline_rounded_button_widget.dart';

class EcommerceList extends StatelessWidget {
  const EcommerceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF7AD0E2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            ),
            _buildEcommerceList(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF7AD0E2),
      title: Text("Belanja di Grouu.id",
          style: TextStyle(
              fontFamily: FontFamily.candyCake,
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
    );
  }

  _buildEcommerceList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EcommerceItem(
          imagePath: "assets/images/banner_bundle_1.png",
          desc:
              "Setiap paket terdiri dari ​2 porsi makanan utama @150ml ​dan 1 porsi makanan selingan @100ml. Dimasak dan dikirim setiap pagi ke Jakarta, Bogor, Depok, Tangerang, Bekasi, dan Bandung.",
        ),
        EcommerceItem(
          imagePath: "assets/images/banner_bundle_2.png",
          desc:
              "Setiap paket terdiri dari ​2 porsi makanan utama @150ml ​dan 1 porsi makanan selingan @100ml. Dimasak dan dikirim setiap pagi ke Jakarta, Bogor, Depok, Tangerang, Bekasi, dan Bandung.",
        ),
        EcommerceItem(
          imagePath: "assets/images/banner_bundle_3.png",
          desc:
              "Setiap paket terdiri dari ​2 porsi makanan utama @150ml ​dan 1 porsi makanan selingan @100ml. Dimasak dan dikirim setiap pagi ke Jakarta, Bogor, Depok, Tangerang, Bekasi, dan Bandung.",
        ),
        EcommerceItem(
          imagePath: "assets/images/banner_bundle_4.png",
          desc:
              "Setiap paket terdiri dari ​2 porsi makanan utama @150ml ​dan 1 porsi makanan selingan @100ml. Dimasak dan dikirim setiap pagi ke Jakarta, Bogor, Depok, Tangerang, Bekasi, dan Bandung.",
        ),
      ],
    );
  }
}

class EcommerceItem extends StatelessWidget {
  const EcommerceItem({super.key, required this.imagePath, required this.desc});
  final String imagePath;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: 15),
            Text(
              desc,
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF828282),
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20),
            OutlineRoundedButtonWidget(
                buttonText: "Kunjungi halaman website",
                onPressed: () async {
                  var url = "https://www.grouu.id/";
                  var uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    throw 'Could not launch $uri';
                  }
                })
          ]),
    );
  }
}
