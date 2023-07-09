import 'package:flutter/material.dart';
import 'package:form_generator/pages/recent_forms_page.dart';

void main() {
  runApp(const FormGeneratorApp());
}

class FormGeneratorApp extends StatelessWidget {
  const FormGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RecentFormsPage(),
      color: Color.fromARGB(255, 255, 255, 243),
      debugShowCheckedModeBanner: false,
    );
  }
}
