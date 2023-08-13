import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_generator/api/form_element_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/pages/answer_form_page.dart';
import 'package:form_generator/pages/edit_form_page.dart';
import 'package:form_generator/pages/recent_forms_page.dart';

void main() {
  Beamer.setPathUrlStrategy();
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
          '/edit-form/:formId': (context, state, data) {
            // Take the path parameter of interest from BeamState
            final formId = state.pathParameters['formId']!;
            return BeamPage(
                key: ValueKey(formId),
                title: 'فرم آنلاین',
                popToNamed: '/',
                type: BeamPageType.scaleTransition,
                child: FutureBuilder<List<FormElementModel>>(
                  future: formElementModelApiService
                      .getFormElementModelsById(int.parse(formId)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Display a loading indicator if needed
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No data available.');
                    } else {
                      return EditFormPage(existedFormElements: snapshot.data!);
                    }
                  },
                ));
          },
          '/form/:formId': (context, state, data) {
            // Take the path parameter of interest from BeamState
            final formId = state.pathParameters['formId']!;
            //     var formElements =
            // await formElementModelApiService.getFormElementModelsById(formId);
            return BeamPage(
                key: ValueKey(formId),
                title: 'فرم آنلاین',
                popToNamed: '/',
                type: BeamPageType.scaleTransition,
                child: FutureBuilder<List<FormElementModel>>(
                  future: formElementModelApiService
                      .getFormElementModelsById(int.parse(formId)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Display a loading indicator if needed
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No data available.');
                    } else {
                      return AnswerFormPage(formElements: snapshot.data!);
                    }
                  },
                ));
          }
        },
      ),
    );

    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
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
