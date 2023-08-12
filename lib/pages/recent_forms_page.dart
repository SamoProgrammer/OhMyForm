import 'package:flutter/material.dart';
import 'package:form_generator/api/form_api_service.dart';
import 'package:form_generator/api/form_element_api_service.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:form_generator/models/form_model.dart';
import 'package:form_generator/pages/edit_form_page.dart';

class RecentFormsPage extends StatefulWidget {
  const RecentFormsPage({super.key});

  @override
  State<RecentFormsPage> createState() => _RecentFormsPageState();
}

class _RecentFormsPageState extends State<RecentFormsPage> {
  final FormModelApiService formApiProvider = FormModelApiService();
  final FormElementModelApiService formElementModelApiService =
      FormElementModelApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: FractionalOffset.centerRight,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text("ایجاد فرم"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text("فرم های اخیر"),
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
                                  8, // Number of columns in the grid
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final form = snapshot.data![index];
                              return GestureDetector(
                                  onTap: () async {
                                    await formElementModelApiService
                                        .getFormElementModelsById(form.id)
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditFormPage(
                                                existedFormElements: value),
                                          ));
                                    });
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(form.title),
                                        Text(form.authorId.toString()),
                                        Text(form.endTime.toString())
                                      ],
                                    ),
                                  ));
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
