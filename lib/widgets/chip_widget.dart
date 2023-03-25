import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
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
    return ChoiceChip(
      padding: EdgeInsets.all(10.0),
      label: Text(text),
      labelStyle: TextStyle(color: selected? Color(0xff00a5c3) : Color(0xff7b7b7b)),
      selected: selected,
      onSelected: (value) => onSelected(value),
      disabledColor: Color(0xfff6f6f6),
      backgroundColor: Color(0xfff6f6f6),
      selectedColor: Color(0xffEEFBFE),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: selected? Color(0xff00a5c3) : Color(0xffe1e1e1)),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}
