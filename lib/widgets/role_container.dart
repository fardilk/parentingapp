import 'package:flutter/material.dart';
import 'package:grouu/constants/app_theme.dart';
import 'package:grouu/widgets/selectable_card.dart';

class RoleContainer extends StatelessWidget {
  const RoleContainer({
    Key? key,
    required this.active,
    required this.onPress,
    required this.image,
    required this.text,
  }) : super(key: key);

  final bool active;
  final Function onPress;
  final Image image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image,
              SizedBox(height: 8),
              Text(text, style: AppThemeData.lightThemeData.textTheme.overline)
            ],
          ),
        ),
        isSelected: active,
        onPress: () => onPress());
  }
}
