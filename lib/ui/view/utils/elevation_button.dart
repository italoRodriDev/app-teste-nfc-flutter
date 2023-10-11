import 'package:flutter/material.dart';

class CustomElevationButton extends StatelessWidget {
  String labelBtn;
  dynamic fontSizeTextBtn;
  double padding;
  double radiusBtn;
  double? elevation;
  dynamic gradientColor1;
  dynamic gradientColor2;
  dynamic textColor;
  double? sizeIconBtn;
  dynamic colorIcon;
  dynamic colorBorder;
  IconData? icon;
  FontWeight? fontWeight;
  VoidCallback onPressed;
  VoidCallback? onChange;

  CustomElevationButton({
    Key? key,
    required this.labelBtn,
    required this.padding,
    required this.radiusBtn,
    required this.gradientColor1,
    required this.gradientColor2,
    required this.elevation,
    required this.onPressed,
    this.colorBorder,
    this.onChange,
    this.fontWeight,
    this.fontSizeTextBtn,
    this.textColor,
    this.colorIcon,
    this.sizeIconBtn,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
        height: 40,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientColor1, gradientColor2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(radiusBtn),
            color: colorBorder),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: colorBorder ?? Colors.transparent),
              textStyle: TextStyle(fontWeight: fontWeight),
              elevation: 0,
              onPrimary: Colors.white,
              primary: Colors.transparent,
              padding: EdgeInsets.all(padding),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radiusBtn))),
            ),
            onPressed: onPressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  IconButton(
                    icon: Icon(
                      icon,
                      color: colorIcon,
                      size: sizeIconBtn,
                    ),
                    onPressed: onPressed,
                  ),
                Text(
                  labelBtn,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: fontWeight,
                    fontSize: fontSizeTextBtn,
                    color: textColor,
                  ),
                ),
              ],
            )));
  }
}
