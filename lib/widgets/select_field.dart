import 'package:flutter/material.dart';

class SelectField extends StatefulWidget {
  const SelectField({super.key});

  @override
  State<SelectField> createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text('Type of field'),
          TextButton(onPressed: () {}, child: Text('add'))
        ],
      ),
    );
  }
}
