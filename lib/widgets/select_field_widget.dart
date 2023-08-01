import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element.dart';
import 'package:form_generator/models/form_element_type.dart';

class SelectFieldWidget extends StatefulWidget {
  final FormElementType elementType;
  final String elementTypeName;
  final IconData elementTypeIcon;
  final void Function(FormElement) onAdd;
  const SelectFieldWidget(
      {super.key,
      required this.elementType,
      required this.elementTypeName,
      required this.elementTypeIcon,
      required this.onAdd});

  @override
  State<SelectFieldWidget> createState() => _SelectFieldWidgetState();
}

class _SelectFieldWidgetState extends State<SelectFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        // margin: const EdgeInsets.symmetric(vertical: 10),
        width: constraints.maxWidth * 0.35,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.elementTypeName,
              style: const TextStyle(fontSize: 18),
            ),
            Icon(widget.elementTypeIcon),
            TextButton(
              onPressed: () {
                setState(() {
                  widget
                      .onAdd(FormElement(label: "", type: widget.elementType));
                });
              },
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(7)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  backgroundColor: Colors.lightBlue[600]),
              child: const Text(
                'افزودن',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
