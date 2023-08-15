// To parse this JSON data, do
//
//     final formElementValueModel = formElementValueModelFromJson(jsonString);

import 'dart:convert';

List<FormElementValueModel> formElementValueModelFromJson(String str) =>
    List<FormElementValueModel>.from(
        json.decode(str).map((x) => FormElementValueModel.fromJson(x)));

String formElementValueModelToJson(List<FormElementValueModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FormElementValueModel {
  final int answeredBy;
  final String value;
  final int formElementId;

  FormElementValueModel({
    required this.answeredBy,
    required this.value,
    required this.formElementId,
  });

  factory FormElementValueModel.fromJson(Map<String, dynamic> json) =>
      FormElementValueModel(
        answeredBy: json["answeredBy"],
        value: json["value"],
        formElementId: json["formElementId"],
      );

  Map<String, dynamic> toJson() => {
        "answeredBy": answeredBy,
        "value": value,
        "formElementId": formElementId,
      };
}
