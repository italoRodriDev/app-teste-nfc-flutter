import 'package:flutter/material.dart';

import '../../../../components/button_component.dart';
import '../../../core/colors.dart';

class ShowAlertCurstom extends StatelessWidget {
  String title;
  String description;
  String labelCancel;
  String labelOk;
  bool isEnableCancel;
  Function() onPressedCancel;
  Function() onPressedOk;

  ShowAlertCurstom(
      {Key? key,
      required this.title,
      required this.description,
      required this.labelCancel,
      required this.labelOk,
      required this.onPressedCancel,
      required this.onPressedOk,
      required this.isEnableCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, fontStyle: FontStyle.normal, color: AppColor.medium),
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13, fontStyle: FontStyle.normal, color: AppColor.medium),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isEnableCancel
                ? ButtonComponent(
                    labelBtn: labelCancel,
                    padding: 10,
                    radiusBtn: 4,
                    textColor: AppColor.medium,
                    colorBorder: AppColor.medium,
                    gradientColor1: AppColor.background,
                    gradientColor2: AppColor.background,
                    elevation: 2,
                    onPressed: () => onPressedCancel())
                : Container(),
            const SizedBox(width: 20),
            ButtonComponent(
                labelBtn: labelOk,
                padding: 10,
                radiusBtn: 4,
                gradientColor1: AppColor.tertiary,
                gradientColor2: AppColor.primary,
                elevation: 2,
                onPressed: () => onPressedOk()),
          ],
        ),
      ],
    );
  }
}
