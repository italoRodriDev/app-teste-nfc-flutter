import 'package:flutter/material.dart';

enum ValueIndicatorType { thumb, tooltip }

class RangeComponent extends StatefulWidget {
  final Color? primaryColor;
  final Color? valueIndicatorColor;
  final double initialValue;
  final double min;
  final double max;
  final int? divisions;
  final IconData? thumbIconData;
  final bool showTooltip;
  final ValueIndicatorType valueIndicatorType;
  final Function(double)? onChanged;

  const RangeComponent(
      {this.initialValue = 50,
      this.min = 0,
      this.max = 100,
      this.divisions,
      this.primaryColor,
      this.valueIndicatorColor,
      this.onChanged,
      this.thumbIconData,
      this.showTooltip = true,
      this.valueIndicatorType = ValueIndicatorType.tooltip,
      Key? key})
      : super(key: key);

  @override
  State<RangeComponent> createState() => _RangeComponentState();
}

class _RangeComponentState extends State<RangeComponent> {
  late double _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  setValue(double newValue) {
    setState(() {
      _value = newValue;
    });
  }

  SliderComponentShape? buildThumbShape() {
    switch (widget.valueIndicatorType) {
      case ValueIndicatorType.thumb:
        return ThumbSliderComponentShape(
            thumbRadius: 16,
            min: widget.min,
            max: widget.max,
            thumbIconData: widget.thumbIconData);
      case ValueIndicatorType.tooltip:
        return null;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: widget.primaryColor,
        inactiveTrackColor: widget.primaryColor?.withOpacity(.3),
        thumbColor: widget.primaryColor,
        valueIndicatorColor: widget.valueIndicatorColor,
        showValueIndicator: widget.showTooltip
            ? ShowValueIndicator.always
            : ShowValueIndicator.never,
        overlayColor: widget.primaryColor?.withOpacity(.2),
        thumbShape: buildThumbShape(),
      ),
      child: Slider(
        value: _value,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        onChanged: (val) {
          setValue(val);
          if (widget.onChanged != null) widget.onChanged!(val);
        },
        label: _value.toStringAsFixed(0),
      ),
    );
  }
}

class ThumbSliderComponentShape extends SliderComponentShape {
  final double thumbRadius;
  final double min;
  final double max;
  final IconData? thumbIconData;

  const ThumbSliderComponentShape({
    required this.thumbRadius,
    this.min = 0,
    this.max = 10,
    this.thumbIconData,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = sliderTheme.thumbColor! //Thumb Background Color
      ..style = PaintingStyle.fill;

    final bool hasThumbIcon = thumbIconData != null;

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: hasThumbIcon ? thumbRadius * 1.33 : thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        //Text Color of Value on Thumb
        fontFamily: hasThumbIcon ? thumbIconData!.fontFamily : null,
        package: hasThumbIcon ? thumbIconData!.fontPackage : null,
      ),
      text: thumbIconData != null
          ? String.fromCharCode(thumbIconData!.codePoint)
          : getValue(value!),
    );

    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
