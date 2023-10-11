import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../components/button_component.dart';
import '../../../../core/colors.dart';
import '../../../components/text_component.dart';
import '../../../controllers/contact.controller.dart';
import '../utils/toolbar.dart';

class ContactPage extends GetView<ContactController> {
  ContactController contactCtrl = Get.put(ContactController());
  @override
  Widget build(BuildContext context) {
    contactCtrl.context = context;
    contactCtrl.writeTagNFC();
    return GetBuilder<ContactController>(
        init: contactCtrl,
        builder: (_) {
          return SafeArea(
              child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: ToolbarApp(
                  labelScreen: 'TESTE DE NFC', automaticallyImplyLeading: true),
            ),
            body: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: SingleChildScrollView(
                  child: Column(children: [
                const SizedBox(height: 20),
                TextComponent(
                    textAlign: TextAlign.center,
                    value: 'Compartilhe seu contato via NFC ou QR Code.'),
                TextComponent(
                    textAlign: TextAlign.center,
                    value:
                        'Para utilizar NFC os dois aparelhos devem estar com a funcionalidade NFC ativa.'),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Center(
                        child: QrImageView(
                      data: _.linkUser,
                      version: QrVersions.auto,
                      size: 200.0,
                    )),
                    const SizedBox(height: 10),
                    ButtonComponent(
                        labelBtn: 'Compartilhar',
                        padding: 2,
                        radiusBtn: 4,
                        iconSVGEnable: true,
                        iconSVG: 'assets/icons/whatsapp.svg',
                        colorIcon: AppColor.primary,
                        colorBorder: AppColor.primary,
                        textColor: AppColor.primary,
                        gradientColor1: const Color.fromARGB(255, 4, 206, 207),
                        gradientColor2: const Color.fromARGB(255, 64, 169, 243),
                        elevation: 0,
                        onPressed: () async {
                          await contactCtrl.openLink();
                        }),
                    const SizedBox(height: 10),
                    ButtonComponent(
                        labelBtn: 'Copiar link',
                        iconSVGEnable: true,
                        iconSVG: 'assets/icons/copiar.svg',
                        padding: 2,
                        radiusBtn: 4,
                        colorIcon: AppColor.primary,
                        textColor: AppColor.primary,
                        gradientColor1: const Color.fromARGB(255, 4, 206, 207),
                        gradientColor2: const Color.fromARGB(255, 64, 169, 243),
                        elevation: 0,
                        onPressed: () async {
                          await contactCtrl.copyLink();
                        }),
                    const SizedBox(height: 10),
                    ButtonComponent(
                        labelBtn: 'Ler TAG',
                        iconSVGEnable: true,
                        iconSVG: 'assets/icons/copiar.svg',
                        padding: 2,
                        radiusBtn: 4,
                        colorIcon: AppColor.primary,
                        textColor: AppColor.primary,
                        gradientColor1: const Color.fromARGB(255, 4, 206, 207),
                        gradientColor2: const Color.fromARGB(255, 64, 169, 243),
                        elevation: 0,
                        onPressed: () async {
                          contactCtrl.readTagNFC();
                        }),
                    ButtonComponent(
                        labelBtn: 'Gravar TAG',
                        iconSVGEnable: true,
                        iconSVG: 'assets/icons/copiar.svg',
                        padding: 2,
                        radiusBtn: 4,
                        colorIcon: AppColor.primary,
                        textColor: AppColor.primary,
                        gradientColor1: const Color.fromARGB(255, 4, 206, 207),
                        gradientColor2: const Color.fromARGB(255, 64, 169, 243),
                        elevation: 0,
                        onPressed: () async {
                          contactCtrl.writeTagNFC();
                        }),
                    ButtonComponent(
                        labelBtn: 'Bloquear gravação de Tag',
                        iconSVGEnable: true,
                        iconSVG: 'assets/icons/copiar.svg',
                        padding: 2,
                        radiusBtn: 4,
                        colorIcon: AppColor.primary,
                        textColor: AppColor.primary,
                        gradientColor1: const Color.fromARGB(255, 4, 206, 207),
                        gradientColor2: const Color.fromARGB(255, 64, 169, 243),
                        elevation: 0,
                        onPressed: () async {
                          contactCtrl.ndefWriteLockNFC();
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
                ValueListenableBuilder(
                    valueListenable: _.resultNFC,
                    builder: (context, dynamic value, child) {
                      if (value != null) {
                        return TextComponent(
                            value: 'Resultado NFC: ' + value.toString());
                      } else {
                        return Container();
                      }
                    })
              ])),
            ),
          ));
        });
  }
}
