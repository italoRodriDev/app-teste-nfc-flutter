import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testenfc/routes/app_pages.dart';
import 'package:testenfc/routes/app_routes.dart';
import 'package:testenfc/ui/theme/app_theme.dart';

void main() async {
  runApp(GetMaterialApp(
    title: 'App de Testes',
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    initialRoute: Routes.ASSINATURA_DIGITAL,
    theme: appThemeData,
  ));
}
