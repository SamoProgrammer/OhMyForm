import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_model.dart';
import 'package:form_generator/widgets/form_element_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';

class AnswerFormPage extends StatefulWidget {
  final List<FormElementModel> formElements;
  final FormModel form;
  const AnswerFormPage(
      {super.key, required this.formElements, required this.form});

  @override
  State<AnswerFormPage> createState() => _AnswerFormPageState();
}

class _AnswerFormPageState extends State<AnswerFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: [
                  Text(
                    widget.form.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.formElements.length,
                        itemBuilder: (context, index) {
                          return FormElementWidget(
                              element: widget.formElements[index]);
                        }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child:
                        InfoButtonWidget(text: "ارسال پاسخ", onPressed: () {
                          
                        }),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
