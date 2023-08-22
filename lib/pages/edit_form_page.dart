import 'package:flutter/material.dart';
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
  const EditFormPage({super.key, required this.existedFormElements});

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
        elementType: FormElementType.description,
        elementTypeIcon: FontAwesomeIcons.info,
        elementTypeName: 'توضیحات',
        onAdd: _addWidget,
        formId: widget.existedFormElements.first.formId,
      ),
      SelectFieldWidget(
        elementType: FormElementType.radioButton,
        elementTypeIcon: FontAwesomeIcons.listCheck,
        elementTypeName: 'چند گزینه ای',
        onAdd: _addWidget,
        formId: widget.existedFormElements.first.formId,
      ),
      SelectFieldWidget(
        elementType: FormElementType.shortText,
        elementTypeIcon: Icons.short_text,
        elementTypeName: 'متن کوتاه',
        onAdd: _addWidget,
        formId: widget.existedFormElements.first.formId,
      ),
      SelectFieldWidget(
        elementType: FormElementType.multiLineText,
        elementTypeIcon: Icons.text_increase,
        elementTypeName: 'متن بلند',
        onAdd: _addWidget,
        formId: widget.existedFormElements.first.formId,
      ),
    ]);
    formElements.addAll(widget.existedFormElements);
    super.initState();
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
                                      .then((value) {
                                    print("done");
                                    Navigator.pop(context);
                                  });
                                }),
                          ),
                          InfoButtonWidget(text: "بازگشت", onPressed: () {})
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
                      return FormElementWidget(element: formElements[index],isEditMode: true,);
                    })),
          ),
        ],
      ),
    );
  }
}
