import 'package:flutter/material.dart';

import '../core/colors.dart';

class SelectComponent extends StatefulWidget {
  final Function(dynamic)? onChanged;
  final List<MenuItemData> menuItemData;
  final Color? primaryColor;
  final String? labelText;
  final dynamic initialValue;
  final double width;

  const SelectComponent(
      {this.onChanged,
      this.menuItemData = const [],
      this.primaryColor,
      this.labelText,
      required this.width,
      this.initialValue,
      Key? key})
      : super(key: key);

  @override
  _SelectComponentState createState() => _SelectComponentState();
}

class _SelectComponentState extends State<SelectComponent> {
  dynamic value;
  late FocusNode focusNode;
  late bool hasFocus;

  @override
  void initState() {
    super.initState();
    hasFocus = false;
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasPrimaryFocus;
      });
    });
    value = widget.initialValue ?? widget.menuItemData.first.value;
  }

  setValue(dynamic val) {
    setState(() {
      value = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    Widget buildBaseItem({required String label, Color? textColor}) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(color: textColor),
        ),
      );
    }

    List<DropdownMenuItem> buildMenuItems() {
      return widget.menuItemData.map(
        (data) {
          bool isSelected = value == data.value;
          return DropdownMenuItem(
            child: FocusScope(
              child: Row(
                children: [
                  buildBaseItem(
                      label: data.label,
                      textColor: isSelected ? AppColor.primary : Colors.black),
                  if (isSelected) ...[
                    const Spacer(),
                    const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ]
                ],
              ),
            ),
            value: data.value,
          );
        },
      ).toList();
    }

    List<Widget> buildSelectedMenuItems(BuildContext context) {
      return widget.menuItemData
          .map(
            (data) => buildBaseItem(label: data.label),
          )
          .toList();
    }

    return Container(
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.labelText != null) ...[
              Text(
                widget.labelText!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 6),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1.25,
                    color: hasFocus
                        ? widget.primaryColor ?? currentTheme.primaryColor
                        : Colors.grey[400]!),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  focusColor: widget.primaryColor ?? currentTheme.primaryColor,
                  shadowColor: Colors.red,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    focusColor: Colors.black,
                    focusNode: focusNode,
                    value: value,
                    isExpanded: true,
                    icon: Icon(
                      value == widget.menuItemData.first.value
                          ? Icons.keyboard_arrow_down_rounded
                          : value == widget.menuItemData.last.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.unfold_more_rounded,
                    ),
                    selectedItemBuilder: buildSelectedMenuItems,
                    onChanged: (dynamic val) {
                      setValue(val);
                      if (widget.onChanged != null) {
                        widget.onChanged!(val);
                      }
                    },
                    items: buildMenuItems(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class MenuItemData {
  final String label;
  final dynamic value;

  const MenuItemData({required this.label, required this.value});
}
