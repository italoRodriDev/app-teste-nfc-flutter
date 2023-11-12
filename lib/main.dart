import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testenfc/routes/app_pages.dart';
import 'package:testenfc/routes/app_routes.dart';
import 'package:testenfc/ui/theme/app_theme.dart';
import 'package:testenfc/ui/view/sincronizar-dados-offline/sqlite.provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteApi.openDatabaseApp();
  runApp(GetMaterialApp(
    title: 'App de Testes',
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    initialRoute: Routes.NFC,
    theme: appThemeData,
  ));
}
