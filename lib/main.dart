import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_generator/api/form_element_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/pages/answer_form_page.dart';
import 'package:form_generator/pages/recent_forms_page.dart';

void main() async {
  runApp(
    const FormGeneratorApp(),
  );
}

class FormGeneratorApp extends StatelessWidget {
  const FormGeneratorApp({super.key});
  @override
  Widget build(BuildContext context) {
    final FormElementModelApiService formElementModelApiService =
        FormElementModelApiService();

    final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          // Return either Widgets or BeamPages if more customization is needed
          '/': (context, state, data) => const RecentFormsPage(),
          // '/forms': (context, state, data) => BooksScreen(),
          '/forms/:formId': (context, state, data) {
            // Take the path parameter of interest from BeamState
            final formId = state.pathParameters['formId']!;
            final formElements = <FormElementModel>[];
            formElementModelApiService
                .getFormElementModelsById(int.parse(formId))
                .then((value) => value);
            return BeamPage(
              key: ValueKey(formId),
              title: 'فرم آنلاین',
              popToNamed: '/',
              type: BeamPageType.scaleTransition,
              child: AnswerFormPage(formElements: formElements),
            );
          }
        },
      ),
    );

    return MaterialApp(
      home: const RecentFormsPage(),
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
