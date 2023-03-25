import 'package:flutter/material.dart';

class DeleteReasonWidget extends StatelessWidget {
  const DeleteReasonWidget({
    Key? key,
    this.onChanged,
    required this.value,
    required this.child,
  }) : super(key: key);

  final ValueChanged<bool?>? onChanged;
  final bool value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onChanged: onChanged,
        ),
        Expanded(child: child)
      ],
    );
  }
}
