import 'package:chat_app/providers/login_provider.dart';
import 'package:chat_app/widgets/email_text_field.dart';
import 'package:chat_app/widgets/main_image.dart';
import 'package:chat_app/widgets/password_text_field.dart';
import 'package:chat_app/widgets/register_login_button.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kNavy,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(icon: Icon(Icons.arrow_back_ios, color: kCoralPink,),
              onPressed: (){
                Navigator.pop(context);
              },),
            ),
          ),
          MainImage(
            imageHeight: MediaQuery.of(context).size.height / 2.5,
            imageWidth: MediaQuery.of(context).size.width / 2,
          ),
          EmailTextField(),
          PasswordTextField(),
          RegisterLoginButton(
              buttonText: 'Login',
              buttonFunction: () async {
                  try{
                    final user = await _auth.signInWithEmailAndPassword(
                        email: loginProvider.email,
                        password: loginProvider.password);

                    if(user != null){
                      Navigator.pushNamed(context, ChatScreen.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Login Successful'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  } on FirebaseAuthException catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text('${e.message}'),
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
