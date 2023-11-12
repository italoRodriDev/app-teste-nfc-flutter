import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:testenfc/components/input_text_component.dart';
import 'package:testenfc/components/text_component.dart';
import 'package:testenfc/controllers/sincronizar-dados.controller.dart';
import 'package:testenfc/ui/utils/show_snackbar.dart';
import 'package:testenfc/ui/view/sincronizar-dados-offline/sqlite.provider.dart';

import '../../../components/button_component.dart';
import '../../../core/colors.dart';
import '../../utils/toolbar.dart';

class SincronizarDadosPage extends GetView<SincronizarDadosController> {
  ValueNotifier<bool> internetEvent = ValueNotifier<bool>(true);
  TextEditingController textNameCtrl = TextEditingController();
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //getStatusInternetDevice(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ToolbarApp(
              labelScreen: 'Sincronia de dados offline',
              automaticallyImplyLeading: true),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            InputTextComponent(
                                textEditingController: textNameCtrl,
                                labelText: 'Nome',
                                hintText: 'Digite seu nome...',
                                borderColor: AppColor.primary),
                            const SizedBox(height: 20),
                            ButtonComponent(
                                labelBtn: 'Salvar Dados',
                                padding: 2,
                                radiusBtn: 4,
                                iconSVGEnable: false,
                                textColor: Colors.white,
                                gradientColor1:
                                    const Color.fromARGB(255, 4, 206, 207),
                                gradientColor2:
                                    const Color.fromARGB(255, 64, 169, 243),
                                elevation: 0,
                                onPressed: () async {
                                  if (textNameCtrl.text.isNotEmpty) {
                                    final bool isConnected =
                                        await verificarConexao();
                                    if (isConnected) {
                                      ShowSnackbar.show(context,
                                          text: 'Salvo na nuvem com sucesso!',
                                          type: SnackBarType.success);
                                    } else {
                                      await SqliteApi.insertDataUser(
                                          textNameCtrl.text);
                                      ShowSnackbar.show(context,
                                          text:
                                              'Sem conexão com a internet, salvo localmente!',
                                          type: SnackBarType.error);
                                    }
                                  }
                                }),
                            const SizedBox(height: 20),
                            ValueListenableBuilder(
                                valueListenable: internetEvent,
                                builder: (context, bool value, child) {
                                  if (value == false) {
                                    return Column(
                                      children: [
                                        Lottie.asset(
                                            'assets/animations/sync_animation.json',
                                            width: 100,
                                            height: 100),
                                        TextComponent(value: 'Sincronizado com sucesso...')    
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                })
                          ],
                        ))
                  ],
                ))));
  }

  Future<bool> verificarConexao() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // -> Verificando conexao
  getStatusInternetDevice(context) async {
    final connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        await ShowSnackbar.show(context,
            text: 'Sem conexão com a internet!', type: SnackBarType.error);
      } else {
        internetEvent.value = false;
        await getDataUser();
      }
      // Got a new connectivity status!
    });
  }

  getDataUser() async {
    var nome = await SqliteApi.getDataUser();
    print(nome.toString());
    Future.delayed(Duration(seconds: 20)).then((value) {
      internetEvent.value = true;
    });
  }
}
