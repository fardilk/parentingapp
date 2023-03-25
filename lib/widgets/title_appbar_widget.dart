import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:iconly/iconly.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleAppBar({Key? key, required this.title, this.useSearchButton})
      : super(key: key);

  final String title;
  final bool? useSearchButton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsIconTheme: IconThemeData(color: Colors.white),
      title: Text(title,
          style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
      backgroundColor: Color(0xff7AD0E2),
      foregroundColor: Colors.white,
      actions: [
        useSearchButton == true
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.article_search);
                },
                icon: Icon(IconlyBold.search),
              )
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.notification);
                },
                icon: Icon(IconlyBold.notification),
              )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
