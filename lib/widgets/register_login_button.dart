import 'package:flutter/material.dart';

class RegisterLoginButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonFunction;
  final Color buttonColor;
  final Color textColor;

  const RegisterLoginButton({
    Key? key, required this.buttonText, required this.buttonFunction, required this.buttonColor, required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          child: Text(buttonText, style: TextStyle(
              color: textColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
          ),
          ),
          onPressed: buttonFunction,
        ),
      ),
    );
  }
}