import 'package:flutter/material.dart';
import 'package:form_generator/database/models/form_element.dart';

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
    if (widget.element.type == 'text') {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
      );
    } else if (widget.element.type == 'email') {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        keyboardType: TextInputType.emailAddress,
      );
    } else if (widget.element.type == 'tel') {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        keyboardType: TextInputType.phone,
      );
    }
    return formElementWidget;
  }
}
