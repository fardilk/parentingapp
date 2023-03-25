import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  const SelectableCard({
    Key? key,
    required this.child,
    required this.isSelected,
    required this.onPress,
  }) : super(key: key);

  final Widget child;
  final bool isSelected;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onPress(),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffF6F6F6),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: isSelected
                ? Border.all(
                    color: Color(0xff00A5C3),
                    width: 2.0,
                    style: BorderStyle.solid,
                  )
                : Border.all(
                    color: Color(0xffE1E1E1),
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: child,
          ),
        ),
      ),
    );
  }
}
