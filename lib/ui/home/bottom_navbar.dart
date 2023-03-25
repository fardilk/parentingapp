import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:iconly/iconly.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
    required this.pageIndex,
    required this.onTap(int index),
    required this.isLoggedIn,
  });

  final int pageIndex;
  final Function(int) onTap;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Icon(pageIndex == 0 ? IconlyBold.home : IconlyLight.home),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Icon(pageIndex == 1 ? IconlyBold.bag_2 : IconlyLight.bag_2),
          ),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Icon(pageIndex == 2 ? IconlyBold.star : IconlyLight.star),
          ),
          label: 'Milestone',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Icon(
                pageIndex == 3 ? IconlyBold.document : IconlyLight.document),
          ),
          label: 'Articles',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child:
                Icon(pageIndex == 4 ? IconlyBold.profile : IconlyLight.profile),
          ),
          label: isLoggedIn ? 'Profile' : 'Login',
        ),
      ],
      showUnselectedLabels: true,
      currentIndex: pageIndex,
      selectedItemColor: Color(0xff00A5C3),
      unselectedItemColor: Color(0xffB9B9B9),
      elevation: 10,
      iconSize: 24,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      unselectedLabelStyle:
          TextStyle(fontFamily: FontFamily.avenirLTStd, fontSize: 8),
      selectedLabelStyle:
          TextStyle(fontFamily: FontFamily.avenirLTStd, fontSize: 8),
      onTap: onTap,
    );
  }
}
