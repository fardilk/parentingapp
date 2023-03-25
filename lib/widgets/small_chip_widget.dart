import 'package:flutter/material.dart';

class SmallChipWidget extends StatelessWidget {
  const SmallChipWidget({
    Key? key,
    required this.text,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  final String text;
  final bool selected;
  final Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ChoiceChip(
        elevation: 0,
        pressElevation: 0,
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.zero,
        label: Text(text),
        labelStyle: TextStyle(
            color: !selected ? const Color(0xff00A5C3) : Colors.white, fontSize: 12),
        selected: selected,
        onSelected: (value) => onSelected(value),
        disabledColor: const Color(0xffDEF4F8),
        backgroundColor: const Color(0xffDEF4F8),
        selectedColor: const Color(0xff00A5C3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
