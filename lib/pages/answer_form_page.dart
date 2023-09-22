import 'package:flutter/material.dart';
import 'package:form_generator/api/answers_api_service.dart';
import 'package:form_generator/api/form_api_service.dart';
import 'package:form_generator/api/user_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_element_value_model.dart';
import 'package:form_generator/models/form_model.dart';
import 'package:form_generator/widgets/form_element_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerFormPage extends StatefulWidget {
  final List<FormElementModel> formElements;
  final FormModel form;
  final bool isUserAnswerdForm;
  const AnswerFormPage(
      {super.key,
      required this.formElements,
      required this.form,
      required this.isUserAnswerdForm});

  @override
  State<AnswerFormPage> createState() => _AnswerFormPageState();
}

class _AnswerFormPageState extends State<AnswerFormPage> {
  AnswersApiService answersApiService = AnswersApiService();
  List<FormElementModel> newFormElements = [];
  List<FormElementValueModel> formElementValues = [];
  List<TextEditingController> controllers = [];
  @override
  void initState() {
    newFormElements.addAll(widget.formElements);
    for (var i = 1; i <= newFormElements.length; i++) {
      controllers.add(TextEditingController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isUserAnswerdForm
          ? const Center(
              child: Text("شما به این فرم قبلا پاسخ دادید"),
            )
          : SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Text(
                        widget.form.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: newFormElements.length,
                            itemBuilder: (context, index) {
                              return FormElementWidget(
                                isEditMode: false,
                                element: newFormElements[index],
                                controller: controllers[index],
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        child: InfoButtonWidget(
                            text: "ارسال پاسخ",
                            onPressed: () async {
                              await fillFormElementValues();

                              await answersApiService
                                  .postFormElementsValue(formElementValues)
                                  .whenComplete(() {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const AlertDialog(
                                      content: Column(
                                    children: [
                                      Text("فرم ارسال شد"),
                                      Text("میتوانید صفحه مرورگر را ببندید"),
                                    ],
                                  )),
                                );
                              });
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> fillFormElementValues() async {
    var preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username')!;
    List<FormElementValueModel> newFormElementValues = [];
    for (var element in newFormElements) {
      setState(() {
        newFormElementValues.add(FormElementValueModel(
            answeredBy: username,
            value: controllers[newFormElements.indexOf(element)].text,
            formElementId: element.id!));
      });
    }
    setState(() {
      formElementValues = [];
      formElementValues.addAll(newFormElementValues);
    });
  }
}
