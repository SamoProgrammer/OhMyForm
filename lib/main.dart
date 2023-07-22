import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_generator/database/models/form_element.dart';
import 'package:form_generator/database/models/form_element_type.dart';
import 'package:form_generator/pages/edit_form_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FormElementTypeAdapter());
  Hive.registerAdapter(FormElementAdapter());
  runApp(const FormGeneratorApp());
}

class FormGeneratorApp extends StatelessWidget {
  const FormGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const EditFormPage(),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("fa", "IR")],
      locale: const Locale("fa", "IR"),
      theme: ThemeData(fontFamily: 'Vazir'),
      color: const Color.fromARGB(255, 255, 255, 243),
      debugShowCheckedModeBanner: false,
    );
  }
}
