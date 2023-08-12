// To parse this JSON data, do
//
//     final form = formFromJson(jsonString);

import 'dart:convert';

List<FormModel> formFromJson(String str) => List<FormModel>.from(json.decode(str).map((x) => FormModel.fromJson(x)));

String formToJson(List<FormModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FormModel {
    final int id;
    final int authorId;
    final String title;
    final DateTime endTime;

    FormModel({
        required this.id,
        required this.authorId,
        required this.title,
        required this.endTime,
    });

    factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        id: json["id"],
        authorId: json["authorId"],
        title: json["title"],
        endTime: DateTime.parse(json["endTime"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "authorId": authorId,
        "title": title,
        "endTime": endTime.toIso8601String(),
    };
}
