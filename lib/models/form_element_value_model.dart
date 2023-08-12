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
  final int id;
  final String label;
  final String options;
  final int formId;
  final int type;

  FormElementValueModel({
    required this.id,
    required this.label,
    required this.options,
    required this.formId,
    required this.type,
  });

  factory FormElementValueModel.fromJson(Map<String, dynamic> json) =>
      FormElementValueModel(
        id: json["id"],
        label: json["label"],
        options: json["options"],
        formId: json["formId"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "options": options,
        "formId": formId,
        "type": type,
      };
}
