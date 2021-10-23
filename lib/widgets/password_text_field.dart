import 'package:chat_app/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:provider/provider.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final passwordTextController = TextEditingController();
  bool _isObscure = true;
  bool _passwordValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var passwordProvider = Provider.of<LoginProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left:40.0, right: 40.0, top: 10.0, bottom: 30.0),
      child: TextField(
        keyboardType: TextInputType.number,
        style: TextStyle(color: kBubbleBlue),
        controller: passwordTextController,
        onChanged: (text){
          passwordProvider.setPassword(text);
          setState(() {
            _passwordValid = RegExp(r'(^(?:[+0]9)?[0-9]{6,12}$)').hasMatch(text);
            passwordProvider.setPasswordValid(_passwordValid);
            passwordProvider.setPassword(text);
          });
        },
        obscureText: _isObscure,
        decoration: InputDecoration(
            helperText: _passwordValid ? '' : 'Password must only contain numbers',
            helperStyle: TextStyle(color: kCoralPink),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: _passwordValid ? Colors.green : Colors.red,
                width: 2,
              ),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: kCoralPink),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                width: 2,
                color: kCoralPink,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: kCoralPink,),
              onPressed: (){
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            )
        ),
      ),
    );
  }
}