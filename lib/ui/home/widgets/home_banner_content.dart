import 'package:flutter/material.dart';

class HomeBannerContent {
  final String imageString;
  final String url;

  HomeBannerContent({required this.imageString, required this.url});
}

List<HomeBannerContent> homeBannerContent = [
  HomeBannerContent(
    imageString: "assets/images/banner_home_1.jpg",
    url:
        'https://www.grouu.id/shopnow/mini-meals?utm_source=app&utm_medium=organik&utm_campaign=mini-meals',
  ),
  HomeBannerContent(
    imageString: "assets/images/banner_home_2.jpg",
    url:
        'https://www.grouu.id/shopnow/ala-carte-meals?utm_source=app&utm_medium=organik&utm_campaign=ala-carte-meals',
  ),
  HomeBannerContent(
    imageString: "assets/images/banner_home_3.jpg",
    url:
        'https://www.grouu.id?utm_source=app&utm_medium=organik&utm_campaign=home',
  ),
];
