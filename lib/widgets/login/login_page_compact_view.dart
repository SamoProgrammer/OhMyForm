import 'package:flutter/material.dart';
import 'package:form_generator/widgets/login/login_page_hero_image.dart';
import 'package:form_generator/widgets/login/login_form.dart';

class LoginPageCompactView extends StatelessWidget {
  final String afterLogin;
  const LoginPageCompactView({
    Key? key,
    required this.welcomeImage,
    
    required this.afterLogin
  })  : 
        super(key: key);

  final String welcomeImage;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: LoginPageHeroImage(welcomeImage: welcomeImage),
          ),
          LoginForm(afterLogin: afterLogin),
        ],
      );
    });
  }
}
