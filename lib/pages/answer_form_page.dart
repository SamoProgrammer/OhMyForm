import 'package:flutter/material.dart';
import 'package:form_generator/api/answers_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_element_value_model.dart';
import 'package:form_generator/models/form_model.dart';
import 'package:form_generator/widgets/form_element_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerFormPage extends StatefulWidget {
  final List<FormElementModel> formElements;
  final FormModel form;
  const AnswerFormPage(
      {super.key, required this.formElements, required this.form});

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
    for (var i = 0; i <= newFormElements.length; i++) {
      controllers.add(TextEditingController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        fillFormElementValues();
                        await answersApiService
                            .postFormElementsValue(formElementValues)
                            .then((value) {
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

  void fillFormElementValues() async {
    var preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username')!;
    List<FormElementValueModel> newFormElementValues = [];
    for (var element in newFormElements) {
      newFormElementValues.add(FormElementValueModel(
          answeredBy: username,
          value: controllers[newFormElements.indexOf(element)].text,
          formElementId: element.id!));
    }
    setState(() {
      formElementValues = newFormElementValues;
    });
  }
}
