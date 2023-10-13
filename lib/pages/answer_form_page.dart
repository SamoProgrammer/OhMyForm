import 'package:flutter/material.dart';
import 'package:form_generator/api/answers_api_service.dart';
import 'package:form_generator/api/form_api_service.dart';
import 'package:form_generator/api/user_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_element_value_model.dart';
import 'package:form_generator/models/form_model.dart';
import 'package:form_generator/widgets/form_element_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerFormPage extends StatefulWidget {
  final List<FormElementModel> formElements;
  final FormModel form;
  final String isUserAnswerdForm;
  const AnswerFormPage(
      {super.key,
      required this.formElements,
      required this.form,
      required this.isUserAnswerdForm});

  @override
  State<AnswerFormPage> createState() => _AnswerFormPageState();
}

class _AnswerFormPageState extends State<AnswerFormPage> {
  AnswersApiService answersApiService = AnswersApiService();
  List<FormElementModel> newFormElements = [];
  List<FormElementValueModel> formElementValues = [];
  List<TextEditingController> controllers = [];
  String errorMessage = "";
  @override
  void initState() {
    newFormElements.addAll(widget.formElements);
    for (var i = 1; i <= newFormElements.length; i++) {
      controllers.add(TextEditingController());
    }
    if (widget.isUserAnswerdForm == "true") {
      errorMessage = "شما به این فرم قبلا پاسخ دادید";
    } else if (widget.isUserAnswerdForm == "time") {
      errorMessage = "زمان پاسخگویی به این فرم به پایان رسیده است";
    }
    print(errorMessage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: widget.isUserAnswerdForm == "true" ||
              widget.isUserAnswerdForm == "time"
          ? Center(
              child: Text(errorMessage),
            )
          : SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage("assets/images/form_background.jpg"))
                  gradient: LinearGradient(
                    colors: [
                      // Color.fromARGB(255, 235, 225, 188),
                      // Color.fromARGB(255, 232, 188, 234),
                      // Color.fromARGB(255, 203, 209, 244),
                      Color.fromARGB(255, 32, 38, 57),
                      Color.fromARGB(255, 63, 76, 119),
                    ], // Define your gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: GlassContainer.clearGlass(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height,
                      borderRadius: BorderRadius.circular(15),
                      borderColor: Colors.grey[200],
                      // color: const Color.fromARGB(255, 224, 247, 250)
                      //     .withOpacity(0.2),
                      color: Colors.white,
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.60),
                          Colors.white.withOpacity(0.10),
                          Colors.lightBlueAccent.withOpacity(0.05),
                          Colors.lightBlueAccent.withOpacity(0.6)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 0.39, 0.40, 1.0],
                      ),
                      blur: 20.0,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: newFormElements.length,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Center(
                                      child: Text(
                                        newFormElements[index].label,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                    );
                                  }
                                  return FormElementWidget(
                                    isEditMode: false,
                                    element: newFormElements[index],
                                    controller: controllers[index],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                // color: Color.fromARGB(255, 254, 235, 176)
                                gradient: LinearGradient(
                                  colors: [
                                    // Color.fromARGB(255, 254, 235, 176),
                                    Color.fromARGB(255, 32, 38, 57),
                                    Color.fromARGB(255, 63, 76, 119),
                                  ], // Define your gradient colors
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    elevation:
                                        5, // Set elevation for the 3D effect
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 24.0,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await fillFormElementValues()
                                        .whenComplete(() async {
                                      await answersApiService
                                          .postFormElementsValue(
                                              formElementValues)
                                          .whenComplete(() {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) =>
                                              const AlertDialog(
                                                  content: Column(
                                            children: [
                                              Text("فرم ارسال شد"),
                                              Text(
                                                  "میتوانید صفحه مرورگر را ببندید"),
                                            ],
                                          )),
                                        );
                                      });
                                    });
                                  },
                                  child: const Text(
                                    "ارسال پاسخ",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> fillFormElementValues() async {
    var preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username')!;
    List<FormElementValueModel> newFormElementValues = [];
    for (var element in newFormElements) {
      setState(() {
        newFormElementValues.add(FormElementValueModel(
            answeredBy: username,
            value: controllers[newFormElements.indexOf(element)].text,
            formElementId: element.id!));
      });
    }
    setState(() {
      formElementValues = [];
      formElementValues.addAll(newFormElementValues);
    });
  }
}
