import 'package:form_generator/api/user_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogService {
  Future<String> checkUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final UserApiService userApiService = UserApiService();
    if (!prefs.containsKey("token")) {
      return 'false';
    }
    final token = prefs.getString("token");
    var loginResult = await userApiService.testLogin(token!);
    if (loginResult != 'false') {
      return loginResult;
    }
    return 'false';
  }
}
