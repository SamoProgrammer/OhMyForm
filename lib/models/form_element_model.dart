// To parse this JSON data, do
//
//     final formElement = formElementFromJson(jsonString);

import 'dart:convert';

List<FormElementModel> formElementFromJson(String str) => List<FormElementModel>.from(json.decode(str).map((x) => FormElementModel.fromJson(x)));

String formElementToJson(List<FormElementModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FormElementModel {
    int? id;
    String label;
    String options;
    int formId;
    int type;

    FormElementModel({
        this.id,
        required this.label,
        required this.options,
        required this.formId,
        required this.type,
    });

    factory FormElementModel.fromJson(Map<String, dynamic> json) => FormElementModel(
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
