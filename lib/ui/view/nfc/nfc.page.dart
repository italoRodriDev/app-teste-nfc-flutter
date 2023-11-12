import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/text_component.dart';
import '../../../controllers/nfc.controller.dart';
import '../../utils/toolbar.dart';
import 'nfc.component.dart';

class NfcPage extends GetView<NfCController> {
  NfCController contactCtrl = Get.put(NfCController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NfCController>(
        init: contactCtrl,
        builder: (_) {
          return SafeArea(
              child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: ToolbarApp(
                  labelScreen: 'NFC', automaticallyImplyLeading: true),
            ),
            body: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: SingleChildScrollView(
                  child: Column(children: [
                const SizedBox(height: 20),
                TextComponent(
                    textAlign: TextAlign.center,
                    value: 'Copie o link ou texto a baixo'),
                TextComponent(
                    textAlign: TextAlign.center,
                    value:
                        'Para utilizar NFC os dois aparelhos devem estar com a funcionalidade NFC ativa.'),
                const SizedBox(height: 20),
                NfcComponent()
              ])),
            ),
          ));
        });
  }
}
