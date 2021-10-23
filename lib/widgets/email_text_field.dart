import 'package:chat_app/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:provider/provider.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({Key? key}) : super(key: key);

  @override
  _EmailTextFieldState createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  bool _emailValid = false;

  @override
  Widget build(BuildContext context) {
    var emailProvider = Provider.of<LoginProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left:40.0, right: 40.0, bottom: 10.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: kBubbleBlue),
        onChanged: (text){
          emailProvider.setEmail(text);
          setState(() {
            _emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
            emailProvider.setEmail(text);
            emailProvider.setEmailValid(_emailValid);
          });
        },
        decoration: InputDecoration(
          helperText: _emailValid ? '' : 'Email is not valid',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 2,
              color: _emailValid ? Colors.green : Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              width: 2.0,
              color: kCoralPink,
            ),
          ),
          labelText: 'Email',
          labelStyle: TextStyle(color: kCoralPink),
          helperStyle: TextStyle(color: kCoralPink),
        ),
      ),
    );
  }
}
