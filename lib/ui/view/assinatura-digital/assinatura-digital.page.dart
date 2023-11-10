import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testenfc/controllers/assinatura-digital.controller.dart';
import 'package:testenfc/ui/view/assinatura-digital/paint.component.dart';

import '../../../components/text_component.dart';
import '../../utils/toolbar.dart';

class AssinaturaDigitalPage extends GetView<AssinaturaDigitalController> {
  AssinaturaDigitalController assiDigitalCtrl =
      Get.put(AssinaturaDigitalController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssinaturaDigitalController>(
        init: assiDigitalCtrl,
        builder: (_) {
          return PaintComponent();
        });
  }
}
