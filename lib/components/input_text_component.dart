import 'package:flutter/material.dart';

import '../core/colors.dart';

class InputTextComponent extends StatefulWidget {
  const InputTextComponent(
      {this.onChanged,
      this.onSubmitted,
      this.errorText,
      this.textEditingController,
      this.inputFormatters,
      this.autofillHints,
      this.obscureText,
      this.textInputType,
      this.autoFocus = false,
      this.focusNode,
      this.prefixIconData,
      this.hintText,
      this.labelText,
      this.helperText,
      this.showLabelAboveTextField = false,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto,
      this.fillColor,
      this.accentColor,
      this.textColor = Colors.black,
      this.borderRadius = 6,
      this.validator,
      this.showConfirmation = true,
      this.showError = true,
      this.verticalPadding = 20,
      this.horizontalPadding = 12,
      this.textInputAction,
      required this.borderColor,
      Key? key})
      : super(key: key);

  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final dynamic inputFormatters;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final TextInputType? textInputType;
  final bool autoFocus;
  final FocusNode? focusNode;
  final IconData? prefixIconData;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool? obscureText;

  /// Text placed below the text field
  final String? helperText;
  final bool showLabelAboveTextField;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Color? fillColor;
  final Color? accentColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final bool Function(String)? validator;
  final bool showConfirmation;
  final bool showError;
  final double verticalPadding;
  final double horizontalPadding;

  @override
  State<InputTextComponent> createState() => _InputTextComponentState();
}

class _InputTextComponentState extends State<InputTextComponent> {
  FocusNode? focusNode;
  TextEditingController? textEditingController;
  late bool hasConfirmation;
  late bool hasError;
  late bool hasFocus;

  @override
  void initState() {
    super.initState();
    hasFocus = false;
    textEditingController =
        widget.textEditingController ?? TextEditingController();
    // hasConfirmation = textEditingController!.text != null ? isValid : false;
    hasConfirmation = isValid;
    hasError = textEditingController != null ? !isValid : false;
    focusNode = widget.focusNode ?? FocusNode();

    focusNode!.addListener(() {
      setState(() {
        hasFocus = focusNode!.hasPrimaryFocus;
        bool valid = isValid;
        hasConfirmation = valid;
        hasError = !valid;
      });
    });
  }

  bool get isValid {
    if (hasValidator) {
      return widget.validator!(textEditingController!.text);
    }
    return false;
  }

  bool get hasValidator {
    return widget.validator != null;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    OutlineInputBorder buildFocusedBorder() {
      if (hasValidator) {
        if (hasConfirmation && widget.showConfirmation) {
          return OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.success, width: 1.25),
              borderRadius: BorderRadius.circular(widget.borderRadius));
        } else if (hasError) {
          return OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.danger, width: 1.25),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        }
      }
      return OutlineInputBorder(
        borderSide: BorderSide(
            color: widget.accentColor ?? currentTheme.primaryColor,
            width: 1.25),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      );
    }

    OutlineInputBorder buildEnabledBorder() {
      if (hasValidator) {
        if (hasConfirmation) {
          return OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.success),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        } else if (hasError) {
          return OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.danger),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        }
      }
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: widget.borderColor,
        ),
      );
    }

    TextStyle? buildLabelStyle() {
      if (hasFocus) {
        return TextStyle(color: widget.textColor);
      } else {
        return null;
      }
    }

    Icon? buildSuffixIcon() {
      if (hasValidator) {
        if (hasConfirmation) {
          return Icon(Icons.check, color: AppColor.success);
        } else if (hasError) {
          return Icon(
            Icons.error,
            color: AppColor.danger,
            size: 24,
          );
        }
      }
      return null;
    }

    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: widget.accentColor?.withOpacity(.33) ??
            currentTheme.primaryColor.withOpacity(.33),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null && widget.showLabelAboveTextField) ...[
            Text(
              widget.labelText!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: widget.textColor,
              ),
            ),
            const SizedBox(height: 6),
          ],
          TextField(
            onSubmitted: (val) {
              widget.onSubmitted!(val);
            },
            focusNode: focusNode,
            inputFormatters: widget.inputFormatters ?? [],
            obscureText: widget.obscureText ?? false,
            controller: textEditingController,
            autofillHints: widget.autofillHints,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            autofocus: widget.autoFocus,
            onChanged: (val) {
              setState(() {
                hasError = false;
                hasConfirmation = isValid;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
            style: TextStyle(color: widget.textColor),
            cursorColor: widget.textColor,
            decoration: InputDecoration(
              errorText: widget.errorText,
              contentPadding: EdgeInsets.symmetric(
                  vertical: widget.verticalPadding,
                  horizontal: widget.horizontalPadding),
              isDense: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.6)),
              labelText:
                  widget.showLabelAboveTextField ? null : widget.labelText,
              labelStyle: buildLabelStyle(),
              floatingLabelBehavior: widget.floatingLabelBehavior,
              fillColor: widget.fillColor,
              filled: widget.fillColor != null,
              focusedBorder: buildFocusedBorder(),
              enabledBorder: buildEnabledBorder(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              prefixIcon: widget.prefixIconData != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 8),
                      child: Icon(
                        widget.prefixIconData,
                        color: hasFocus
                            ? widget.accentColor
                            : widget.textColor.withOpacity(.6),
                        size: 20,
                      ),
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 24),
              suffixIcon: buildSuffixIcon(),
            ),
          ),
          if (widget.helperText != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.helperText!,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ]
        ],
      ),
    );
  }
}
