import 'package:flutter/material.dart';
import 'package:form_generator/database/models/form_element.dart';
import 'package:form_generator/database/models/form_element_type.dart';

class FormElementWidget extends StatefulWidget {
  final FormElement element;
  const FormElementWidget({super.key, required this.element});

  @override
  State<FormElementWidget> createState() => _FormElementWidgetState();
}

class _FormElementWidgetState extends State<FormElementWidget> {
  @override
  Widget build(BuildContext context) {
    late Widget formElementWidget;
    if (widget.element.type == FormElementType.description) {
      formElementWidget = Text(
        widget.element.label,
        style: const TextStyle(fontSize: 18),
      );
    } else if (widget.element.type == FormElementType.shortText) {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        
      );
    } else if (widget.element.type == FormElementType.multiLineText) {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        
      );
    } else if (widget.element.type == FormElementType.multiChoice) {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        keyboardType: TextInputType.phone,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: formElementWidget,
    );
  }
}
