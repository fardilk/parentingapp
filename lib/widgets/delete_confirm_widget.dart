import 'package:flutter/material.dart';
import 'package:grouu/ui/register/styles/register_styles.dart';
import 'package:grouu/widgets/outline_rounded_button_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';

class DeleteConfirmWidget extends StatefulWidget {
  DeleteConfirmWidget(
      {Key? key, required this.onConfirmTap, required this.dialogWording})
      : super(key: key);
  final String dialogWording;

  final Function() onConfirmTap;

  @override
  State<DeleteConfirmWidget> createState() => _DeleteConfirmWidgetState();
}

class _DeleteConfirmWidgetState extends State<DeleteConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).copyWith().size.height * 0.25,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text("Konfirmasi", style: RegisterStyles.title),
            ),
            Center(
              child: Text(widget.dialogWording,
                  textAlign: TextAlign.center,
                  style: RegisterStyles.textMedium),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlineRoundedButtonWidget(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      buttonText: 'Batal'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RoundedButtonWidget(
                    buttonText: "Yakin",
                    buttonColor: Color(0xffDC3434),
                    textColor: Colors.white,
                    onPressed: () async {
                      widget.onConfirmTap();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
