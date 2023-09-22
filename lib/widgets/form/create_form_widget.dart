import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:form_generator/api/form_api_service.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateFormWidget extends StatefulWidget {
  const CreateFormWidget({super.key});

  @override
  State<CreateFormWidget> createState() => _CreatFormWidgetState();
}

class _CreatFormWidgetState extends State<CreateFormWidget> {
  FormApiService formApiService = FormApiService();
  TimeOfDay pickedTimeOfDay = const TimeOfDay(hour: 0, minute: 0);
  DateTime pickedDateTime = DateTime(1);
  String tempFormTitleControllerValue = "";
  TextEditingController formTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("ایجاد فرم"),
      content: Column(
        children: [
          const Text("نام فرم"),
          TextField(
            controller: formTitleController,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          const Text("تاریخ پایان"),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          InfoButtonWidget(
              text: "انتخاب ساعت",
              onPressed: () async {
                var picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  pickedTimeOfDay = picked!;
                });
              }),
          pickedTimeOfDay.hour != 0
              ? Text("${pickedTimeOfDay.hour}:${pickedTimeOfDay.minute}")
              : Container(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          InfoButtonWidget(
              text: "انتخاب روز و ماه",
              onPressed: () async {
                var picked = await showPersianDatePicker(
                  context: context,
                  initialDate: Jalali.now(),
                  firstDate: Jalali.now(),
                  lastDate: Jalali(1405, 12, 29, 23, 59),
                );
                setState(() {
                  pickedDateTime = picked!.toDateTime();
                });
              }),
          pickedDateTime.year != 1
              ? Text(
                  "${pickedDateTime.year}/${pickedDateTime.day}/${pickedDateTime.month}")
              : Container()
        ],
      ),
      actions: [
        TextButton(
          child: const Text("بستن"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("ایجاد"),
          onPressed: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            final username = prefs.getString("username");
            await formApiService
                .createNewForm(
                    username!,
                    formTitleController.text,
                    pickedDateTime.add(Duration(
                        hours: pickedTimeOfDay.hour,
                        minutes: pickedTimeOfDay.minute)))
                .whenComplete(() {
              Navigator.pop(context);
              Beamer.of(context).beamToNamed("/proccess-request?url=%2F",
                  popBeamLocationOnPop: true);
            });
          },
        ),
      ],
    );
  }
}
