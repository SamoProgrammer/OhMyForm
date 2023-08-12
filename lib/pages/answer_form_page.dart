import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element_model.dart';

class AnswerFormPage extends StatefulWidget {
  final List<FormElementModel> formElements;
  const AnswerFormPage({super.key,required this.formElements});

  @override
  State<AnswerFormPage> createState() => _AnswerFormPageState();
}

class _AnswerFormPageState extends State<AnswerFormPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
