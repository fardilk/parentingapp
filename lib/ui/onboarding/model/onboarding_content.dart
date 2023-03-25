import 'package:flutter/material.dart';

class OnBoardingContent {
  OnBoardingContent({
    required this.image,
    required this.slug,
    required this.title,
    required this.color,
    required this.darkColor,
  });
  final Image image;
  final String title;
  final String slug;
  final Color color;
  final Color darkColor;
}

List<OnBoardingContent> onboardingContents = [
  OnBoardingContent(
    title: "Smart Planner",
    image: Image.asset("assets/images/onboarding_1.png"),
    slug:
        "Pantau dan rencanakan berbagai aktivitas untuk menunjang tumbuh kembang optimal buah hati.",
    color: Color(0xFFE0E88D),
    darkColor: Color(0xFFB6BF05),
  ),
  OnBoardingContent(
    title: "Smart Content",
    image: Image.asset("assets/images/onboarding_2.png"),
    slug:
        "Dapatkan informasi lengkap, akurat, dan terpercaya dari para expert dan komunitas orang tua.",
    color: Color(0xFFF287A5),
    darkColor: Color(0xFFE43068),
  ),
  OnBoardingContent(
    title: "Smart Shopper",
    image: Image.asset("assets/images/onboarding_3.png"),
    slug:
        "Atur jadwal pengiriman berbagai produk pilihan untuk menenuhi kebutuhan buah hati.",
    color: Color(0xFFBF99CB),
    darkColor: Color(0xFF974BA9),
  ),
];
