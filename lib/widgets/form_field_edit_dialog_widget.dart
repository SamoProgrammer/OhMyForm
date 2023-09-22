import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_element_type.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:form_generator/widgets/warning_button_widget.dart';

class FormFieldEditDialogWidget extends StatefulWidget {
  final FormElementModel element;
  final Function(FormElementModel) onUpdate;
  const FormFieldEditDialogWidget(
      {super.key, required this.element, required this.onUpdate});

  @override
  State<FormFieldEditDialogWidget> createState() =>
      _FormFieldEditDialogWidgetState();
}

class _FormFieldEditDialogWidgetState extends State<FormFieldEditDialogWidget> {
  var txtLabelController = TextEditingController();
  var txtOptionsController = TextEditingController();
  late FormElementModel tempElement;
  bool isRadioButton = false;

  @override
  void initState() {
    tempElement = widget.element;
    txtLabelController.text = widget.element.label;
    if (widget.element.type == FormElementType.radioButton.index) {
      isRadioButton = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("عنوان فیلد"),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: 40,
            child: TextField(
              controller: txtLabelController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5))),
            ),
          ),
          if (isRadioButton)
            Column(
              children: [
                const Text("گزینه ها (با ویرگول جدا کنید)"),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                  height: 40,
                  child: TextField(
                    controller: txtOptionsController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5))),
                  ),
                )
              ],
            )
        ],
      ),
      actions: [
        InfoButtonWidget(
            text: "ذخیره",
            onPressed: () {
              setState(() {
                tempElement.label = txtLabelController.text;
                tempElement.options = txtOptionsController.text;
              });
              widget.onUpdate(tempElement);
              Navigator.pop(context);
            }),
        WarningButtonWidget(
            text: "خروج",
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
