import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:form_generator/models/form_model.dart';

class FormApiService {
  final Dio _dio = Dio();

  // Replace with your API URL
  final String _baseUrl = 'http://localhost:5202/api/Form';

  // Method to fetch all forms
  Future<List<FormModel>>? getFormModels() async {
    try {
      final response = await _dio.get(_baseUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => FormModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch forms');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to fetch a single form by ID
  Future<FormModel> getFormModelById(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/$id');

      if (response.statusCode == 200) {
        return FormModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch the form');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to create a new form
  Future<FormModel> createNewForm(
      String username, String title, DateTime endTime) async {
    try {
      var data = json.encode({
        "authorUsername": username,
        "title": title,
        "endTime": "${endTime.toIso8601String()}Z"
      });
      print(data);
      final response = await _dio.post(_baseUrl, data: data);

      if (response.statusCode == 200) {
        return FormModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create the form');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to update an existing form
  Future<void> updateFormModel(FormModel form) async {
    try {
      final response =
          await _dio.put('$_baseUrl/${form.id}', data: form.toJson());

      if (response.statusCode != 204) {
        throw Exception('Failed to update the form');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to delete a form by ID
  Future<bool> deleteFormModel(int id) async {
    try {
      final response = await _dio.delete('$_baseUrl/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete the form');
      }
      return true;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> isUserAnswerdForm(String username, int formId) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/IsUserAnswerdForm',
        queryParameters: {
          'username': username,
          'formId': formId,
        },
      );

      return response.data;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
