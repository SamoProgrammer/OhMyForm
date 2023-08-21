import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApiService {
  final Dio _dio = Dio();

  // Change this to your API base URL
  final String baseUrl = 'http://localhost:5202/api/Users';

  Future<void> registerUser(
      String username, String password, String phoneNumber, String role) async {
    try {
      final response = await _dio.post(
        '$baseUrl/Register',
        data: {
          'Username': username,
          'Password': password,
          'PhoneNumber': phoneNumber,
          'Role': role,
        },
      );
      if (response.statusCode == 200) {
        // Registration successful
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    }
  }

  Future<bool> loginUser(String username, String password) async {
    final response = await _dio.post(
      '$baseUrl/Login',
      queryParameters: {
        'username': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      // Login successful
      // You can access the token using response.data['token']
      saveToken(response.data['token'], username, password);
      return true;
    } else {
      return false;
      // Handle error
    }
  }

  Future<String> testLogin(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    final response = await _dio.get('$baseUrl/TestLogin',
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      // Login successful
      print(response.data);
      return response.data;
    } else {
      return 'false';
      // Handle error
    }
  }

  void saveToken(String token, String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("username", username);
    prefs.setString("password", password);
  }
}
