
import 'package:get/get.dart';
import 'package:testenfc/ui/view/assinatura-digital/assinatura-digital.page.dart';
import 'package:testenfc/ui/view/nfc/nfc.page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.ASSINATURA_DIGITAL,
      page: () => AssinaturaDigitalPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: Routes.NFC,
      page: () => NfcPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];
}
