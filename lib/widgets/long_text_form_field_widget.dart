import 'package:flutter/material.dart';

class LongTextFormFieldWidget extends StatefulWidget {
  final String lable;
  TextEditingController? controller;
   LongTextFormFieldWidget({super.key, required this.lable,this.controller});

  @override
  State<LongTextFormFieldWidget> createState() =>
      _LongTextFormFieldWidgetState();
}

class _LongTextFormFieldWidgetState extends State<LongTextFormFieldWidget> {
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
          maxLines: null,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.5))),
        ),
      ],
    );
  }
}
