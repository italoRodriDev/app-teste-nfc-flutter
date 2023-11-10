import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:share_plus/share_plus.dart';

import '../ui/utils/show_snackbar.dart';

class ContactController extends GetxController {
  late BuildContext context;
  String linkUser = "https://cartao-digital.carrera.com.br/saller.test";
  ValueNotifier<String> linkUserEvent = ValueNotifier<String>('');
  ValueNotifier<dynamic> resultNFC = ValueNotifier<dynamic>('');

  @override
  void onReady() async {
    super.onReady();
  }

  openLink() async {
    var url = Uri.parse(linkUser);
    Share.share(linkUser);
  }

  copyLink() async {
    Clipboard.setData(ClipboardData(text: linkUser));
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      String textoCopiado = data.text!;
      await ShowSnackbar.show(context,
          text: 'Link copiado!', type: SnackBarType.success);
    }
  }

  void writeTagNFC() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        resultNFC.value = 'Tag não é gravável em ndef';
        NfcManager.instance.stopSession(errorMessage: resultNFC.value);
        return;
      }

      NdefMessage message = NdefMessage([
        //NdefRecord.createText('Teste NFC carrera!'),
        NdefRecord.createUri(Uri.parse(linkUser)),
        //NdefRecord.createMime(
        //    'text/plain', Uint8List.fromList('Olá'.codeUnits)),
        //NdefRecord.createExternal(
        //    'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        resultNFC.value = 'Sucesso em "Ndef Write"';
        NfcManager.instance.stopSession();
      } catch (e) {
        resultNFC.value = e;
        NfcManager.instance.stopSession(errorMessage: resultNFC.value.toString());
        return;
      }
    });
  }

  void readTagNFC() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      resultNFC.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  void ndefWriteLockNFC() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        resultNFC.value = 'A tag não é ndef!';
        NfcManager.instance.stopSession(errorMessage: resultNFC.value.toString());
        return;
      }

      try {
        await ndef.writeLock();
        resultNFC.value = 'Sucesso para "Ndef Write Lock"';
        NfcManager.instance.stopSession();
      } catch (e) {
        resultNFC.value = e;
        NfcManager.instance.stopSession(errorMessage: resultNFC.value.toString());
        return;
      }
    });
  }

  startNfcEvent() async {
    var isAvailable = await NfcManager.instance.isAvailable();

    if (isAvailable == false) {
      await ShowSnackbar.show(context,
          text: 'Suporte para NFC não detectado!', type: SnackBarType.error);
    } else {
      unawaited(
          NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);
        var record = ndef!.cachedMessage!.records.first;
        var decodedPayload = ascii.decode(record.payload);
        decodedPayload.substring(decodedPayload.indexOf('myprefex'));
      }));
    }
  }
}
