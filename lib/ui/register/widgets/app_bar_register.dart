import 'package:flutter/material.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:iconly/iconly.dart';

class AppBarRegister extends StatelessWidget implements PreferredSizeWidget {
  const AppBarRegister({super.key, required this.onSkip});

  final Function onSkip;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(IconlyLight.arrow_left_2, color: Colors.white),
        onPressed: () async {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).maybePop();
          } else {
            Navigator.of(context).pushReplacementNamed(Routes.home);
          }
        },
      ),
      title: Image.asset("assets/images/reg_appbar_icon.png"),
      actions: [
        TextButton(
          onPressed: () async => onSkip(),
          child: Text(
            "Lewati",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
