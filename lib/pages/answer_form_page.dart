import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/widgets/form_element_widget.dart';

class AnswerFormPage extends StatefulWidget {
  final List<FormElementModel> formElements;
  const AnswerFormPage({super.key, required this.formElements});

  @override
  State<AnswerFormPage> createState() => _AnswerFormPageState();
}

class _AnswerFormPageState extends State<AnswerFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: widget.formElements.length,
                itemBuilder: (context, index) {
                  return FormElementWidget(element: widget.formElements[index]);
                })),
      ),
    );
  }
}
