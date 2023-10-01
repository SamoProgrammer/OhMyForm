import 'package:dio/dio.dart';
import 'package:form_generator/models/form_element_model.dart';

class FormElementModelApiService {
  final Dio _dio = Dio();

  // Replace with your API base URL
  final String _baseUrl = 'http://localhost:5202/api/FormElement';

  // Method to fetch all form elements
  Future<List<FormElementModel>> getFormElementModels() async {
    try {
      final response = await _dio.get(_baseUrl);

      if (response.statusCode == 200) {
        if (response.data == "[]") {
          return <FormElementModel>[];
        }
        final List<dynamic> data = response.data;
        return data.map((json) => FormElementModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch form elements');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to fetch a single form element by ID
  Future<List<FormElementModel>> getFormElementModelsById(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/$id');

      if (response.statusCode == 200) {
        print("response is :" + response.data.toString());
        if (response.data.toString() == "[]") {
          return <FormElementModel>[];
        }
        final List<dynamic> data = response.data;
        return data.map((json) => FormElementModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch form elements');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to create a new form element
  Future<FormElementModel> createFormElementModel(
      FormElementModel formElement) async {
    try {
      final response = await _dio.post('$_baseUrl/FormElementModel',
          data: formElement.toJson());

      if (response.statusCode == 201) {
        return FormElementModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create the form element');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to update an existing form element
  Future<void> updateFormElementModel(
      List<FormElementModel> formElements) async {
    try {
      final headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
      print(formElementToJson(formElements));
      final response = await _dio.post(
          '$_baseUrl/UpdateFormElements?formId=${formElements.first.formId}',
          options: Options(headers: headers),
          data: formElementToJson(formElements));

      if (response.statusCode != 200) {
        throw Exception('Failed to update the form element');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to delete a form element by ID
  Future<void> deleteFormElementModel(int id) async {
    try {
      final response = await _dio.delete('$_baseUrl/FormElementModel/$id');

      if (response.statusCode != 204) {
        throw Exception('Failed to delete the form element');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
