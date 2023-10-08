import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_generator/api/form_element_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_element_type.dart';
import 'package:form_generator/widgets/form_element_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:form_generator/widgets/warning_button_widget.dart';
import 'package:form_generator/widgets/select_field_widget.dart';

class EditFormPage extends StatefulWidget {
  final List<FormElementModel> existedFormElements;
  final int formId;
  const EditFormPage(
      {super.key, required this.existedFormElements, required this.formId});

  @override
  State<EditFormPage> createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  final List<SelectFieldWidget> selectFieldWidgets = <SelectFieldWidget>[];
  final FormElementModelApiService formElementModelApiService =
      FormElementModelApiService();
  List<FormElementModel> formElements = <FormElementModel>[];
  void _addWidget(FormElementModel element) {
    setState(() {
      formElements.add(element);
    });
  }

  @override
  void initState() {
    selectFieldWidgets.addAll([
      SelectFieldWidget(
        elementType: FormElementType.title,
        elementTypeIcon: FontAwesomeIcons.info,
        elementTypeName: 'عنوان',
        onAdd: _addWidget,
        formId: widget.formId,
      ),
      SelectFieldWidget(
        elementType: FormElementType.description,
        elementTypeIcon: FontAwesomeIcons.info,
        elementTypeName: 'توضیحات',
        onAdd: _addWidget,
        formId: widget.formId,
      ),
      SelectFieldWidget(
        elementType: FormElementType.shortText,
        elementTypeIcon: Icons.short_text,
        elementTypeName: 'متن کوتاه',
        onAdd: _addWidget,
        formId: widget.formId,
      ),
      SelectFieldWidget(
        elementType: FormElementType.multiLineText,
        elementTypeIcon: Icons.text_increase,
        elementTypeName: 'متن بلند',
        onAdd: _addWidget,
        formId: widget.formId,
      ),
      SelectFieldWidget(
        elementType: FormElementType.radioButton,
        elementTypeIcon: FontAwesomeIcons.listCheck,
        elementTypeName: 'چند گزینه ای',
        onAdd: _addWidget,
        formId: widget.formId,
      ),
      SelectFieldWidget(
        elementType: FormElementType.checkBox,
        elementTypeIcon: FontAwesomeIcons.listCheck,
        elementTypeName: 'بله یا خیر',
        onAdd: _addWidget,
        formId: widget.formId,
      ),
    ]);
    formElements.addAll(widget.existedFormElements);
    super.initState();
  }

  void updateElements() async {}

  void deleteElement(FormElementModel element) {
    setState(() {
      formElements.remove(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                border:
                    Border(left: BorderSide(width: 1, color: Colors.black))),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      color: const Color.fromARGB(255, 165, 207, 246),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  width: double.maxFinite,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'افزودن فیلد',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: selectFieldWidgets,
                      )),
                ),
                LayoutBuilder(
                  builder: (c, bc) => SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    width: bc.maxWidth,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.black)),
                          color: Color.fromARGB(255, 165, 207, 246)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: WarningButtonWidget(
                                text: "ذخیره",
                                onPressed: () async {
                                  await formElementModelApiService
                                      .updateFormElementModel(formElements)
                                      .whenComplete(() {
                                    html.window.location.href = "/";
                                  });
                                }),
                          ),
                          InfoButtonWidget(
                              text: "بازگشت",
                              onPressed: () {
                                html.window.location.href = "/";
                              })
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
          SingleChildScrollView(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: formElements.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Center(
                          child: Text(
                            formElements[index].label,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        );
                      }
                      return FormElementWidget(
                        element: formElements[index],
                        isEditMode: true,
                        onDelete: deleteElement,
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
