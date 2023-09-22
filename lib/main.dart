import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_generator/api/form_api_service.dart';
import 'package:form_generator/api/form_element_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_model.dart';
import 'package:form_generator/pages/answer_form_page.dart';
import 'package:form_generator/pages/edit_form_page.dart';
import 'package:form_generator/pages/proccess_request_page.dart';
import 'package:form_generator/pages/recent_forms_page.dart';
import 'package:form_generator/services/user_log_service.dart';
import 'package:form_generator/widgets/login/adaptive_scaffold.dart';
import 'package:form_generator/widgets/login/login_page_compact_view.dart';
import 'package:form_generator/widgets/login/login_page_full_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  UserLogService userLogService = UserLogService();
  Beamer.setPathUrlStrategy();
  runApp(
    FormGeneratorApp(userLogined: await userLogService.checkUserLogin()),
  );
}

class FormGeneratorApp extends StatelessWidget {
  String userLogined;
  bool isUserAnswerdForm = false;
  FormGeneratorApp({super.key, required this.userLogined});

  void reCheckUserLogin() async {
    UserLogService userLogService = UserLogService();
    userLogined = await userLogService.checkUserLogin();
  }

  void checkIfUserAnswerdForm(int formId) async {
    var preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username')!;
    FormApiService formApiService = FormApiService();

    isUserAnswerdForm =
        await formApiService.isUserAnswerdForm(username, formId);
  }

  @override
  Widget build(BuildContext context) {
    final FormElementModelApiService formElementModelApiService =
        FormElementModelApiService();
    final FormApiService formModelApiService = FormApiService();
    const welcomeImage = 'assets/images/welcome.jpg';
    final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          // Return either Widgets or BeamPages if more customization is needed
          '/': (context, state, data) {
            reCheckUserLogin();
            return userLogined == 'Admin'
                ? const BeamPage(child: RecentFormsPage(), key: ValueKey('/'))
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
            print("in form");
            final formId = state.pathParameters['formId']!;
            reCheckUserLogin();
            return userLogined != 'false'
                ? BeamPage(
                    key: const ValueKey("edit-form"),
                    title: 'فرم آنلاین',
                    popToNamed: '/',
                    type: BeamPageType.scaleTransition,
                    child: FutureBuilder(
                      future: formElementModelApiService
                          .getFormElementModelsById(int.parse(formId)),
                      builder: (context, snapshot) {
                        print(snapshot.data);
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
                              existedFormElements: snapshot.data!);
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
            final formId = int.parse(state.pathParameters['formId']!);
            reCheckUserLogin();
            checkIfUserAnswerdForm(formId);
            return userLogined != 'false'
                ? BeamPage(
                    key: const ValueKey("form"),
                    title: 'فرم آنلاین',
                    popToNamed: '/',
                    type: BeamPageType.scaleTransition,
                    child: FutureBuilder(
                      future: Future.wait([
                        formElementModelApiService
                            .getFormElementModelsById(formId),
                        formModelApiService.getFormModelById(formId)
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
                            isUserAnswerdForm: isUserAnswerdForm,
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
          },
          '/proccess-request': (context, state, data) {
            return BeamPage(
                child: ProccessRequestPage(url: state.queryParameters["url"]!));
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
