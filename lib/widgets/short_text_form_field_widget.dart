import 'package:flutter/material.dart';

class ShortTextFormFieldWidget extends StatefulWidget {
  final String lable;
  const ShortTextFormFieldWidget({super.key, required this.lable});

  @override
  State<ShortTextFormFieldWidget> createState() => _ShortTextFormFieldWidgetState();
}

class _ShortTextFormFieldWidgetState extends State<ShortTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: widget.lable,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5))),
    );
  }
}
