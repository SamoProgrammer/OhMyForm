import 'package:flutter/material.dart';

class SelectFieldWidget extends StatefulWidget {
  const SelectFieldWidget({super.key});

  @override
  State<SelectFieldWidget> createState() => _SelectFieldWidgetState();
}

class _SelectFieldWidgetState extends State<SelectFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Type of field'),
          TextButton(onPressed: () {}, child: Text('add'))
        ],
      ),
    );
  }
}
