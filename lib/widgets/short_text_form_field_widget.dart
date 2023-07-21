import 'package:flutter/material.dart';

class ShortTextFormFieldWidget extends StatefulWidget {
  final String lable;
  const ShortTextFormFieldWidget({super.key, required this.lable});

  @override
  State<ShortTextFormFieldWidget> createState() =>
      _ShortTextFormFieldWidgetState();
}

class _ShortTextFormFieldWidgetState extends State<ShortTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            widget.lable,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.5))),
        ),
      ],
    );
  }
}
