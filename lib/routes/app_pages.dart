
import 'package:get/get.dart';
import 'package:testenfc/ui/view/contact/contact.page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => ContactPage(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 1000),
    )
  ];
}
