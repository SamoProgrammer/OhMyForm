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
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
      );
    } else if (widget.element.type == FormElementType.shortText) {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        keyboardType: TextInputType.emailAddress,
      );
    } else if (widget.element.type == FormElementType.multiLineText) {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        keyboardType: TextInputType.phone,
      );
    } else if (widget.element.type == FormElementType.multiChoice) {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        keyboardType: TextInputType.phone,
      );
    }
    return formElementWidget;
  }
}
