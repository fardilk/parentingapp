import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouu/utils/ui/color.dart';

class TextFieldWidget extends StatefulWidget {
  final IconData? icon;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final bool enabled;
  final Widget? suffixWidget;
  final IconData? prefixIcon;
  final Color fillColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();

  const TextFieldWidget({
    Key? key,
    this.icon,
    required this.errorText,
    required this.textController,
    this.inputType,
    this.hint,
    this.isObscure = false,
    this.isIcon = false,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = const Color(0xFF7B7B7B),
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.enabled = true,
    this.suffixWidget,
    this.prefixIcon,
    this.fillColor = const Color(0xfff6f6f6),
    this.contentPadding,
  }) : super(key: key);
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _showPassword = false;

  void _toogleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.textController,
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        autofocus: widget.autoFocus,
        maxLength: widget.inputType == TextInputType.phone ? 12 : null,
        textInputAction: widget.inputAction,
        inputFormatters: widget.inputType == TextInputType.phone
            ? [
                FilteringTextInputFormatter.digitsOnly,
              ]
            : [],
        obscureText: this.widget.isObscure ? !_showPassword : false,
        keyboardType: this.widget.inputType,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            contentPadding: this.widget.contentPadding,
            filled: true,
            fillColor: this.widget.fillColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  width: 1,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: HexColor.fromHex("#E1E1E1"),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: HexColor.fromHex("#44BED5"),
                )),
            disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: HexColor.fromHex("#E1E1E1"),
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: HexColor.fromHex("#E1E1E1"),
                )),
            hintText: this.widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: widget.hintColor,
                ),
            errorText: widget.errorText,
            counterText: '',
            icon: this.widget.isIcon
                ? Icon(this.widget.icon, color: widget.iconColor)
                : null,
            prefixIcon: this.widget.prefixIcon != null
                ? Icon(this.widget.prefixIcon)
                : null,
            suffixIcon: widget.isObscure
                ? GestureDetector(
                    child: Icon(
                      !_showPassword ? Icons.visibility : Icons.visibility_off,
                      color: _showPassword
                          ? Colors.red
                          : HexColor.fromHex("b9b9b9"),
                    ),
                    onTap: () {
                      _toogleVisibility();
                    },
                  )
                : this.widget.icon != null
                    ? Icon(this.widget.icon)
                    : this.widget.suffixWidget != null
                        ? this.widget.suffixWidget
                        : null),
      ),
    );
  }
}
