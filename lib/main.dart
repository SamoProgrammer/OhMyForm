import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_generator/api/form_api_service.dart';
import 'package:form_generator/api/form_element_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_model.dart';
import 'package:form_generator/pages/answer_form_page.dart';
import 'package:form_generator/pages/edit_form_page.dart';
import 'package:form_generator/pages/recent_forms_page.dart';
import 'package:form_generator/services/user_log_service.dart';
import 'package:form_generator/widgets/login/adaptive_scaffold.dart';
import 'package:form_generator/widgets/login/login_page_compact_view.dart';
import 'package:form_generator/widgets/login/login_page_full_view.dart';

void main() async {
  UserLogService userLogService = UserLogService();
  Beamer.setPathUrlStrategy();
  runApp(
    FormGeneratorApp(userLogined: await userLogService.checkUserLogin()),
  );
}

class FormGeneratorApp extends StatelessWidget {
  String userLogined;
  FormGeneratorApp({super.key, required this.userLogined});

  void reCheckUserLogin() async {
    UserLogService userLogService = UserLogService();
    userLogined = await userLogService.checkUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    final FormElementModelApiService formElementModelApiService =
        FormElementModelApiService();
    final FormModelApiService formModelApiService = FormModelApiService();
    const welcomeImage = 'assets/images/welcome.jpg';
    final formKey = GlobalKey<FormState>();
    // if (userLogined == 'false') {
    //   return AdaptiveScaffold(
    //       full: LoginPageFullView(welcomeImage: welcomeImage, formKey: formKey),
    //       compact: LoginPageCompactView(
    //           welcomeImage: welcomeImage, formKey: formKey));
    // }
    final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          // Return either Widgets or BeamPages if more customization is needed
          '/': (context, state, data) {
            reCheckUserLogin();
            return userLogined == 'Admin'
                ? const RecentFormsPage()
                : const AdaptiveScaffold(
                    full: LoginPageFullView(
                      welcomeImage: welcomeImage,
                      afterLogin: '/',
                    ),
                    compact: LoginPageCompactView(
                        welcomeImage: welcomeImage, afterLogin: '/'));
          },
          // '/forms': (context, state, data) => BooksScreen(),
          '/edit-form/:formId': (context, state, data) {
            // Take the path parameter of interest from BeamState
            final formId = state.pathParameters['formId']!;
            reCheckUserLogin();
            return userLogined != 'false'
                ? BeamPage(
                    key: ValueKey(formId),
                    title: 'فرم آنلاین',
                    popToNamed: '/',
                    type: BeamPageType.scaleTransition,
                    child: FutureBuilder<List<FormElementModel>>(
                      future: formElementModelApiService
                          .getFormElementModelsById(int.parse(formId)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Scaffold(
                              body:
                                  CircularProgressIndicator()); // Display a loading indicator if needed
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No data available.');
                        } else {
                          return EditFormPage(
                              existedFormElements:
                                  snapshot.data![0] as List<FormElementModel>);
                        }
                      },
                    ))
                : AdaptiveScaffold(
                    full: LoginPageFullView(
                      welcomeImage: welcomeImage,
                      afterLogin: '/edit-form/$formId',
                    ),
                    compact: LoginPageCompactView(
                        welcomeImage: welcomeImage,
                        afterLogin: '/edit-form/$formId'));
          },
          '/form/:formId': (context, state, data) {
            // Take the path parameter of interest from BeamState
            final formId = state.pathParameters['formId']!;
            reCheckUserLogin();
            return userLogined != 'false'
                ? BeamPage(
                    key: ValueKey(formId),
                    title: 'فرم آنلاین',
                    popToNamed: '/',
                    type: BeamPageType.scaleTransition,
                    child: FutureBuilder(
                      future: Future.wait([
                        formElementModelApiService
                            .getFormElementModelsById(int.parse(formId)),
                        formModelApiService.getFormModelById(int.parse(formId))
                      ]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Scaffold(
                              body:
                                  CircularProgressIndicator()); // Display a loading indicator if needed
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No data available.');
                        } else {
                          return AnswerFormPage(
                            formElements:
                                snapshot.data![0] as List<FormElementModel>,
                            form: snapshot.data![1] as FormModel,
                          );
                        }
                      },
                    ))
                : AdaptiveScaffold(
                    full: LoginPageFullView(
                      welcomeImage: welcomeImage,
                      afterLogin: '/form/$formId',
                    ),
                    compact: LoginPageCompactView(
                        welcomeImage: welcomeImage,
                        afterLogin: '/form/$formId'));
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
