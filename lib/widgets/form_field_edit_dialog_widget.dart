import 'package:flutter/material.dart';
import 'package:form_generator/database/models/form_element.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:form_generator/widgets/warning_button_widget.dart';

class FormFieldEditDialogWidget extends StatefulWidget {
  final FormElement element;
  const FormFieldEditDialogWidget({super.key, required this.element});

  @override
  State<FormFieldEditDialogWidget> createState() =>
      _FormFieldEditDialogWidgetState();
}

class _FormFieldEditDialogWidgetState extends State<FormFieldEditDialogWidget> {
  var formFieldNameController = TextEditingController();
  var formFieldLableController = TextEditingController();
  var formFieldOptionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("نام فیلد (انگلیسی)"),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: 40,
            child: TextFormField(
              controller: formFieldNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5))),
            ),
          ),
          const Text("عنوان فیلد"),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: 40,
            child: TextFormField(
              controller: formFieldNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5))),
            ),
          ),
          const Text("گزینه ها (با ویرگول جدا کنید)"),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: 40,
            child: TextFormField(
              controller: formFieldNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5))),
            ),
          )
        ],
      ),
      actions: [
        InfoButtonWidget(text: "ذخیره", onPressed: () {}),
        WarningButtonWidget(
            text: "خروج",
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
