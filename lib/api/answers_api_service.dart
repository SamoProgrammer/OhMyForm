import 'package:dio/dio.dart';
import 'package:form_generator/models/form_element_value_model.dart';

class AnswersApiService {
  final Dio _dio = Dio(); // You can configure Dio options here if needed
  final String _baseUrl = 'http://localhost:5202/api/FormElementValue';
  Future<bool> postFormElementsValue(
      List<FormElementValueModel> formElementsValues) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: formElementsValues.map((value) => value.toJson()).toList(),
      );

      if (response.statusCode == 200) {
        print('Form element values posted successfully');
        return true;
      } else {
        // Handle errors
        print('Error: ${response.data}');
        return false;
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
    return false;
  }
}
