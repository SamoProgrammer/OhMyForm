import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_generator/api/form_api_service.dart';
import 'package:form_generator/api/form_element_api_service.dart';
import 'package:form_generator/models/form_model.dart';
import 'package:form_generator/widgets/form/create_form_widget.dart';
import 'package:form_generator/widgets/form/form_card_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';

class RecentFormsPage extends StatefulWidget {
  const RecentFormsPage({super.key});

  @override
  State<RecentFormsPage> createState() => _RecentFormsPageState();
}

class _RecentFormsPageState extends State<RecentFormsPage> {
  final FormApiService formApiProvider = FormApiService();
  final FormElementModelApiService formElementModelApiService =
      FormElementModelApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            // width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 7,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.shade200.withOpacity(0.5),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topRight,
                      //   end: Alignment.bottomLeft,
                      //   colors: [
                      //     Colors.blue,
                      //     Colors.red,
                      //   ],
                      // ))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "فرم های اخیر",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        InfoButtonWidget(
                            text: "ایجاد فرم",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const CreateFormWidget();
                                },
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<FormModel>>(
                      future: formApiProvider
                          .getFormModels(), // Call your API method here
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No forms available.'));
                        } else {
                          // Display the list of forms in a grid using GridView.builder
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  4, // Number of columns in the grid
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final form = snapshot.data![index];
                              return SizedBox(
                                child: FormCardWidget(
                                  formTitle: form.title,
                                  formEndTime: form.endTime,
                                  formFieldsCount: form.authorId,
                                  formId: form.id,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
