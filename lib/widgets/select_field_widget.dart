import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_element_type.dart';

class SelectFieldWidget extends StatefulWidget {
  final FormElementType elementType;
  final String elementTypeName;
  final IconData elementTypeIcon;
  final void Function(FormElementModel) onAdd;
  final int formId;
  const SelectFieldWidget(
      {super.key,
      required this.elementType,
      required this.elementTypeName,
      required this.elementTypeIcon,
      required this.onAdd,
      required this.formId});

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
                  widget.onAdd(FormElementModel(
                      options: "",
                      formId: widget.formId,
                      id: 0,
                      label: "",
                      type: widget.elementType.index));
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
