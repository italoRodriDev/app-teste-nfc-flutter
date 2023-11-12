import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:testenfc/ui/utils/show_snackbar.dart';
import '../../../components/button_component.dart';
import '../../../components/input_text_component.dart';
import '../../../core/colors.dart';

class NfcComponent extends StatefulWidget {
  const NfcComponent({super.key});

  @override
  State<NfcComponent> createState() => _NfcComponentState();
}

class _NfcComponentState extends State<NfcComponent> {
  GlobalKey globalKey = GlobalKey();
  TextEditingController textEditUrlCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              ],
            )),
        const SizedBox(height: 20),
        ButtonComponent(
            labelBtn: 'Compartilhar',
            padding: 2,
            radiusBtn: 4,
            colorIcon: AppColor.primary,
            colorBorder: AppColor.primary,
            textColor: AppColor.primary,
            gradientColor1: const Color.fromARGB(255, 4, 206, 207),
            gradientColor2: const Color.fromARGB(255, 64, 169, 243),
            elevation: 0,
            onPressed: () async {
              if (textEditUrlCtrl.text.isNotEmpty) {
                _shareNFC(textEditUrlCtrl.text.toString());
              }
            })
      ],
    );
  }

  Future<void> _shareNFC(String url) async {
    try {
      var availability = await FlutterNfcKit.nfcAvailability;
      if (availability != NFCAvailability.available) {
        await ShowSnackbar.show(context,
            text: 'NFC não disponível neste dispositivo.',
            type: SnackBarType.error);
        return;
      }

      // -> Codifique a URL como um registro NDEF
      var uriRecord = ndef.UriRecord.fromString(url);

      // -> Começa a escutar tags NFC
      var tag = await FlutterNfcKit.poll(
        timeout: Duration(seconds: 10),
        iosMultipleTagMessage: "Várias tags encontradas!",
        iosAlertMessage: "Digitalize sua etiqueta",
      );

      // -> Verifica se a tag é gravável e suporta NDEF
      if (tag.ndefWritable! && tag.ndefAvailable!) {
        // -> Grava o registro NDEF na tag NFC
        await FlutterNfcKit.writeNDEFRecords([uriRecord]);
        await ShowSnackbar.show(context,
            text: 'Tag NFC gerada com sucesso!', type: SnackBarType.error);
      } else {
        await ShowSnackbar.show(context,
            text: 'A etiqueta NFC não é gravável ou não suporta NDEF.',
            type: SnackBarType.error);
      }

      // Call finish() only once
      await FlutterNfcKit.finish();
    } catch (error) {
      await ShowSnackbar.show(context,
          text: 'Error: $error', type: SnackBarType.error);
    }
  }
}
