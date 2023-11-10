import 'package:flutter/material.dart';

enum SnackBarType { error, warning, success, info, elevation }

class ShowSnackbar {
  static SnackBar _buildSnackbar(
      {String? text, SnackBarType? type, double? elevation}) {
    Color? backgroundColor;
    Color? textColor;
    IconData? icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green[100];
        textColor = Colors.green[800];
        icon = Icons.check;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red[100];
        textColor = Colors.red[800];
        icon = Icons.error_outline;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.amber[100];
        textColor = Colors.amber[800];
        icon = Icons.warning_amber_outlined;
        break;
      case SnackBarType.info:
        backgroundColor = Colors.blue[100];
        textColor = Colors.blue[800];
        icon = Icons.info_outline;
        break;
      default:
        {
          //TODO add stuff to prevent returning null
          //statements;
        }
    }

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: elevation == null ? 0 : elevation,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: textColor!),
          borderRadius: BorderRadius.circular(8)),
      content: Row(
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            text!,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
          )),
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }

  static show(BuildContext context,
      {String text = "Action successful!",
      SnackBarType type = SnackBarType.success}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(_buildSnackbar(text: text, type: type));
  }
}
