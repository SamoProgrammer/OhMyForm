import 'package:flutter/material.dart';
import 'package:form_generator/widgets/login/login_page_hero_image.dart';
import 'package:form_generator/widgets/login/login_form.dart';

class LoginPageFullView extends StatelessWidget {
  final String afterLogin;
  const LoginPageFullView(
      {Key? key, required this.welcomeImage, required this.afterLogin})
      : super(key: key);

  final String welcomeImage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Flexible(
              flex: 2,
              child: LoginForm(
                afterLogin: afterLogin,
              )),
          Flexible(
            flex: 3,
            child: LoginPageHeroImage(welcomeImage: welcomeImage),
          ),
        ],
      );
    });
  }
}
