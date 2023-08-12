import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_element_type.dart';
import 'package:form_generator/widgets/danger_button_widget.dart';
import 'package:form_generator/widgets/form_field_edit_dialog_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:form_generator/widgets/long_text_form_field_widget.dart';
import 'package:form_generator/widgets/radio_button_form_field_widget.dart';
import 'package:form_generator/widgets/short_text_form_field_widget.dart';

class FormElementWidget extends StatefulWidget {
  FormElementModel element;
  FormElementWidget({super.key, required this.element});

  @override
  State<FormElementWidget> createState() => _FormElementWidgetState();
}

class _FormElementWidgetState extends State<FormElementWidget> {
  void onUpdate(FormElementModel element) {
    setState(() {
      widget.element = element;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget formElementWidget = Container();
    if (widget.element.type == FormElementType.description.index) {
      formElementWidget = Text(
        widget.element.label,
        style: const TextStyle(fontSize: 18),
      );
    } else if (widget.element.type == FormElementType.shortText.index) {
      formElementWidget = const ShortTextFormFieldWidget(lable: "متن کوتاه");
    } else if (widget.element.type == FormElementType.multiLineText.index) {
      formElementWidget = const LongTextFormFieldWidget(lable: "متن بلند");
    } else if (widget.element.type == FormElementType.radioButton.index) {
      formElementWidget = RadioButtonFormFieldWidget(
        element: widget.element,
      );
    } else if (widget.element.type == FormElementType.checkBox.index) {}
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          formElementWidget,
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: InfoButtonWidget(
                    text: "ویرایش",
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return FormFieldEditDialogWidget(
                            element: widget.element,
                            onUpdate: onUpdate,
                          );
                        },
                      );
                    }),
              ),
              DangerButtonWidget(text: "حذف", onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }
}
