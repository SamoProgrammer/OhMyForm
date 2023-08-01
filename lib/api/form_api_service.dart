import 'package:dio/dio.dart';
import 'package:form_generator/models/form.dart';

class FormApiProvider {
  final Dio _dio = Dio();

  // Replace with your API base URL
  final String _baseUrl = 'https://example.com/api';

  // Method to fetch all forms
  Future<List<Form>> getForms() async {
    try {
      final response = await _dio.get('$_baseUrl/Form');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Form.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch forms');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to fetch a single form by ID
  Future<Form> getFormById(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/Form/$id');

      if (response.statusCode == 200) {
        return Form.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch the form');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to create a new form
  Future<Form> createForm(Form form) async {
    try {
      final response = await _dio.post('$_baseUrl/Form', data: form.toJson());

      if (response.statusCode == 201) {
        return Form.fromJson(response.data);
      } else {
        throw Exception('Failed to create the form');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to update an existing form
  Future<void> updateForm(Form form) async {
    try {
      final response = await _dio.put('$_baseUrl/Form/${form.id}', data: form.toJson());

      if (response.statusCode != 204) {
        throw Exception('Failed to update the form');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to delete a form by ID
  Future<void> deleteForm(int id) async {
    try {
      final response = await _dio.delete('$_baseUrl/Form/$id');

      if (response.statusCode != 204) {
        throw Exception('Failed to delete the form');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
