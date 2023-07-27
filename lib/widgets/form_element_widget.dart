import 'package:flutter/material.dart';
import 'package:form_generator/database/models/form_element.dart';
import 'package:form_generator/database/models/form_element_type.dart';
import 'package:form_generator/widgets/danger_button_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:form_generator/widgets/long_text_form_field_widget.dart';
import 'package:form_generator/widgets/short_text_form_field_widget.dart';

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
      formElementWidget = const ShortTextFormFieldWidget(lable: "متن کوتاه");
    } else if (widget.element.type == FormElementType.multiLineText) {
      formElementWidget = const LongTextFormFieldWidget(lable: "متن بلند");
    } else if (widget.element.type == FormElementType.radioButton) {
      formElementWidget = TextFormField(
        decoration: InputDecoration(labelText: widget.element.label),
        keyboardType: TextInputType.phone,
      );
    } else if (widget.element.type == FormElementType.checkBox) {}
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          formElementWidget,
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: InfoButtonWidget(text: "ویرایش", onPressed: () {}),
              ),
              DangerButtonWidget(text: "حذف", onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }
}
