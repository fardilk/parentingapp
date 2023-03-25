import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class GrowthSliderWidget extends StatefulWidget {
  const GrowthSliderWidget({
    Key? key,
    required this.min,
    required this.max,
    required this.value,
    required this.measurement,
    this.onChanged,
    required this.interval,
  }) : super(key: key);

  final double min;
  final double max;
  final double value;
  final double interval;

  final String measurement;
  final ValueChanged<dynamic>? onChanged;

  @override
  State<GrowthSliderWidget> createState() => _GrowthSliderWidgetState();
}

class _GrowthSliderWidgetState extends State<GrowthSliderWidget> {
  TextEditingController _inputValueController = TextEditingController();
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _inputValueController.text = _value.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _inputValueController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: ShapeDecoration(
            color: Color(0xfff6f6f6),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: Color(0xffE1E1E1)),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: 100,
              child: TextField(
                controller: _inputValueController,
                keyboardType: TextInputType.number,
                decoration: null,
                maxLength: 3,
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(','),
                  NumericalRangeFormatter(min: widget.min, max: widget.max)
                ],
                onChanged: ((value) {
                  double parsedValue = double.parse(value);
                  setState(() {
                    _value = parsedValue;

                    if (widget.onChanged != null) {
                      widget.onChanged!(_value);
                    }
                  });
                }),
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    fontFamily: FontFamily.avenirLTStd,
                    color: Color(0xff676767)),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.measurement,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: FontFamily.avenirLTStd,
              color: Color(0xff676767)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/baby_boy_n_notes.png"),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SfSlider.vertical(
                  min: widget.min,
                  max: widget.max,
                  value: _value,
                  interval: widget.interval,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  stepSize: 0.10,
                  onChanged: ((value) {
                    setState(() {
                      _value =
                          double.parse((value as double).toStringAsFixed(2));
                      _inputValueController.text = _value.toString();
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                    });
                  }),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
