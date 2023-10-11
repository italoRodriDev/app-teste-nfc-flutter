import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class ToolbarApp extends StatelessWidget {
  late String labelScreen;
  bool automaticallyImplyLeading;

  ToolbarApp(
      {Key? key,
      required this.labelScreen,
      required this.automaticallyImplyLeading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 2, left: 18, right: 18),
        child: AppBar(
          automaticallyImplyLeading: automaticallyImplyLeading,
          iconTheme: IconThemeData(color: AppColor.textColor),
          title: Text(
            labelScreen,
            style: TextStyle(color: AppColor.textColor, fontSize: 16.0),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          backgroundColor: Colors.white,
          elevation: 0.8,
        ));
  }
}
