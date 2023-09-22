import 'package:flutter/material.dart';

class CheckBoxFormFieldWidget extends StatefulWidget {
  final String lable;
  TextEditingController? controller;
  CheckBoxFormFieldWidget({super.key, required this.lable, this.controller});

  @override
  State<CheckBoxFormFieldWidget> createState() =>
      _LongTextFormFieldWidgetState();
}

class _LongTextFormFieldWidgetState extends State<CheckBoxFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    bool checkedValue = false;
    return Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            title: Text(widget.lable),
            value: checkedValue,
            onChanged: (newValue) {
              setState(() {
                checkedValue = newValue!;
                widget.controller!.text = checkedValue.toString();
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        )
      ],
    );
  }
}
