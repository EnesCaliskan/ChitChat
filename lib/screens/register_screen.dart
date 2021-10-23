import 'package:chat_app/providers/login_provider.dart';
import 'package:chat_app/widgets/email_text_field.dart';
import 'package:chat_app/widgets/main_image.dart';
import 'package:chat_app/widgets/password_text_field.dart';
import 'package:chat_app/widgets/register_login_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

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
              buttonText: 'Register',
              buttonFunction: () async {
                try{
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: loginProvider.email,
                      password: loginProvider.password);
                  if(newUser != null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Register Successful'),
                      ),
                    );
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } on FirebaseAuthException catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text('${e.message}'),
                    ),
                  );
                }
              },
              buttonColor: kBubbleBlue,
              textColor: kCoralPink),
        ],
      ),
    );
  }
}
