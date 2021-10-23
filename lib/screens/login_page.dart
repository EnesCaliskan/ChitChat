import 'package:chat_app/providers/login_provider.dart';
import 'package:chat_app/widgets/email_text_field.dart';
import 'package:chat_app/widgets/main_image.dart';
import 'package:chat_app/widgets/password_text_field.dart';
import 'package:chat_app/widgets/register_login_button.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              buttonText: 'Login',
              buttonFunction: (){

                if(loginProvider.emailValid && loginProvider.passwordValid){
                  //login bilgilerini al



                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Login Successful'),
                     ),
                   );
                  Navigator.pushNamed(context, ChatScreen.id);
                  } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text('Invalid email or password'),
                    ),
                  );
                  }
                },
              buttonColor: kCoralPink,
              textColor: kBubbleBlue),
        ],
      ),
    );
  }
}
