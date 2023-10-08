import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:form_generator/api/form_api_service.dart';
import 'package:form_generator/api/form_element_api_service.dart';
import 'package:form_generator/pages/proccess_request_page.dart';
import 'dart:html' as html;
import 'package:form_generator/widgets/danger_button_widget.dart';
import 'package:form_generator/widgets/info_button_widget.dart';
import 'package:form_generator/widgets/warning_button_widget.dart';
import 'package:intl/intl.dart';

class FormCardWidget extends StatefulWidget {
  final String formTitle;
  final DateTime formEndTime;
  final int formFieldsCount;
  final int formId;
  const FormCardWidget(
      {super.key,
      required this.formTitle,
      required this.formEndTime,
      required this.formFieldsCount,
      required this.formId});

  @override
  State<FormCardWidget> createState() => _FormCardWidgetState();
}

class _FormCardWidgetState extends State<FormCardWidget> {
  final formatNumber = NumberFormat("###", "fa_ir");
  final FormApiService formApiProvider = FormApiService();
  final FormElementModelApiService formElementModelApiService =
      FormElementModelApiService();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            widget.formTitle,
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[800],
            ),
          ),
          Text(
            "تاریخ پایان",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Text(
            "${formatNumber.format(widget.formEndTime.hour)}:${formatNumber.format(widget.formEndTime.minute)}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
          Text(
            "${formatNumber.format(widget.formEndTime.year)}/${formatNumber.format(widget.formEndTime.day)}/${formatNumber.format(widget.formEndTime.month)}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // const Spacer(),
              WarningButtonWidget(
                  text: "ویرایش",
                  onPressed: () async {
                    await formElementModelApiService
                        .getFormElementModelsById(widget.formId)
                        .then((value) {
                      Beamer.of(context)
                          .beamToNamed('/edit-form/${widget.formId}');
                    });
                  }),
              DangerButtonWidget(
                  text: "حذف",
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("هشدار"),
                          content:
                              const Text("آیا از حذف این فرم مطمئن هستید؟"),
                          actions: [
                            DangerButtonWidget(
                                text: "بله",
                                onPressed: () async {
                                  await formApiProvider
                                      .deleteFormModel(widget.formId)
                                      .whenComplete(() {
                                    Navigator.pop(context);
                                    html.window.location.href = "/";
                                  });
                                }),
                            InfoButtonWidget(
                                text: "خیر",
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
          InfoButtonWidget(
              text: "دریافت اکسل",
              onPressed: () {
                formApiProvider.convertFormDataToCsv(widget.formId);
              })
        ],
      ),
    );
  }
}
