import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../components/button_component.dart';
import '../../../../core/colors.dart';
import '../../../components/input_text_component.dart';
import '../../../components/text_component.dart';
import '../../../controllers/nfc.controller.dart';
import '../../utils/toolbar.dart';
import 'nfc.component.dart';

class NfcPage extends GetView<NfCController> {
  NfCController contactCtrl = Get.put(NfCController());
  GlobalKey globalKey = GlobalKey();
  TextEditingController textEditUrlCtrl = TextEditingController();

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
                Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        InputTextComponent(
                            textEditingController: textEditUrlCtrl,
                            labelText: 'URL/Texto',
                            hintText: 'Digite a URL ou texto...',
                            borderColor: AppColor.primary),
                        const SizedBox(height: 20),
                        NfcComponent(textTag: textEditUrlCtrl.text)
                      ],
                    ))
              ])),
            ),
          ));
        });
  }
}
