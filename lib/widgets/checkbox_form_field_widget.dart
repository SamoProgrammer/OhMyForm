import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CheckBoxFormFieldWidget extends StatefulWidget {
  final String lable;
  TextEditingController? controller;
  CheckBoxFormFieldWidget({super.key, required this.lable, this.controller});

  @override
  State<CheckBoxFormFieldWidget> createState() =>
      _LongTextFormFieldWidgetState();
}

class _LongTextFormFieldWidgetState extends State<CheckBoxFormFieldWidget> {
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GFCheckbox(
          size: GFSize.MEDIUM,
          activeBgColor: Colors.red,
          type: GFCheckboxType.square,
          inactiveIcon: null,
          value: checkedValue,
          onChanged: (newValue) {
            setState(() {
              checkedValue = newValue;
              widget.controller!.text = checkedValue.toString();
              print(newValue);
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            widget.lable,
            style: const TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }
}
