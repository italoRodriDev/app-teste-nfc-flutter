import 'package:flutter/material.dart';

import 'alert_dialog.dart';

class AlertsApp {
  // -> Alerta clientes na fila
  static showAlert(
      {required BuildContext context,
      required String title,
      required String description,
      required String labelCancel,
      required String labelOk,
      required Function onPressedCancel,
      required Function onPressedOk,
      required bool enabledCancel}) {
    return showDialog<String>(
        context: context,
        builder: (context) => ShowAlertCurstom(
            title: title,
            description: description,
            labelCancel: labelCancel,
            labelOk: labelOk,
            onPressedCancel: () => onPressedCancel(),
            onPressedOk: () => onPressedOk(),
            isEnableCancel: enabledCancel));
  }
}
