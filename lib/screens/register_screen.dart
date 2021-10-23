import 'package:chat_app/widgets/email_text_field.dart';
import 'package:chat_app/widgets/main_image.dart';
import 'package:chat_app/widgets/password_text_field.dart';
import 'package:chat_app/widgets/register_login_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kNavy,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainImage(
            imageHeight: MediaQuery.of(context).size.height / 2.5,
            imageWidth: MediaQuery.of(context).size.width / 2,
          ),
          EmailTextField(),
          PasswordTextField(),
          RegisterLoginButton(
              buttonText: 'Register',
              buttonFunction: (){

              },
              buttonColor: kBubbleBlue,
              textColor: kCoralPink),
        ],
      ),
    );
  }
}
