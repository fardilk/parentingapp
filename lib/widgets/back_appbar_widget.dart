import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  final Widget title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff7AD0E2),
      title: title,
      leading: IconButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(true),
          icon: Icon(IconlyLight.arrow_left_2)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
