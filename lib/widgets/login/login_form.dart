import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:form_generator/api/user_api_service.dart';
import 'package:form_generator/widgets/info_button_widget.dart';

class LoginForm extends StatelessWidget {
  final String afterLogin;

  const LoginForm({Key? key, required this.afterLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget okButton = InfoButtonWidget(
      text: "باشه",
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog wrongLoginAlert = AlertDialog(
      title: const Text("اطلاعات اشتباه"),
      content: const Text("نام کاربری یا رمز عبور اشتباه است"),
      actions: [
        okButton,
      ],
    );
    UserApiService userApiService = UserApiService();
    var txtUsernameController = TextEditingController();
    var txtPasswordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'خوش آمدید',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'برای استفاده از خدمات این وبسایت باید وارد شوید',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Column(children: [
            TextField(
              controller: txtUsernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'نام کاربری',
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: txtPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'رمز عبور',
              ),
            )
          ]),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              bool loginResult = false;
              await userApiService
                  .loginUser(
                      txtUsernameController.text, txtPasswordController.text)
                  .then((value) => {loginResult = value})
                  .whenComplete(() {
                if (loginResult) {
                  Beamer.of(context).beamToNamed(afterLogin);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => wrongLoginAlert,
                  );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(1024, 60),
            ),
            child: const Text(
              'ورود',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
