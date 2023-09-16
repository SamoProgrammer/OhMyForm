import 'package:flutter/material.dart';
import 'package:form_generator/api/form_api_service.dart';

class CreatFormWidget extends StatefulWidget {
  const CreatFormWidget({super.key});

  @override
  State<CreatFormWidget> createState() => _CreatFormWidgetState();
}

class _CreatFormWidgetState extends State<CreatFormWidget> {
  TextEditingController formNameController = TextEditingController();
  FormApiService formApiService = FormApiService();
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("بستن"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: const Text("ایجاد"),
    onPressed: () async {
      await formApiService.createFormModel()
    },
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("ایجاد فرم"),
      content: Column(
        children: [
          const Text("نام فرم"),
          TextField(
            controller: formNameController,
          )
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}
