import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier{
  late String _email;
  late String _password;
  late bool _emailValid;
  late bool _passwordValid;

  LoginProvider(){
    _email = '';
    _password = '';
    _emailValid = false;
    _passwordValid = false;

  }

  //getters
  String get email => _email;
  String get password => _password;
  bool get emailValid => _emailValid;
  bool get passwordValid => _passwordValid;

  //setters
  void setEmail(String email){
    _email = email;
    notifyListeners();
  }

  void setPassword(String password){
    _password = password;
    notifyListeners();
  }

  void setEmailValid(bool emailValid){
    _emailValid = emailValid;
    notifyListeners();
  }

  void setPasswordValid(bool passwordValid){
    _passwordValid = passwordValid;
    notifyListeners();
  }




}