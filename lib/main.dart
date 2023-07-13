import 'package:flutter/material.dart';
import 'package:form_generator/pages/recent_forms_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const FormGeneratorApp());
}

class FormGeneratorApp extends StatelessWidget {
  const FormGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RecentFormsPage(),
      theme: ThemeData(fontFamily: 'Google'),
      color: const Color.fromARGB(255, 255, 255, 243),
      debugShowCheckedModeBanner: false,
    );
  }
}
