import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testenfc/routes/app_pages.dart';
import 'package:testenfc/routes/app_routes.dart';
import 'package:testenfc/ui/view/theme/app_theme.dart';

void main() async {
  runApp(GetMaterialApp(
    title: 'Teste NFC',
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    initialRoute: Routes.HOME,
    theme: appThemeData,
  ));
}
