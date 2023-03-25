import 'package:flutter/material.dart';

class TabSelectorWidget extends StatelessWidget {
  const TabSelectorWidget({
    super.key,
    required this.active,
    required this.onTap,
    required this.text,
  });

  final bool active;
  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
          onPressed: () => onTap(),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: active ? Color(0xff44BED5) : Color(0xffA4A4A4),
                ),
              ),
              active
                  ? Container(
                      height: 2,
                      width: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color(0xff44BED5),
                      ),
                    )
                  : SizedBox(),
            ],
          )),
    );
  }
}
