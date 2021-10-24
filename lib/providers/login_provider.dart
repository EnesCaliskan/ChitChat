import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier{
  late String _email;
  late String _password;

  LoginProvider(){
    _email = '';
    _password = '';
  }

  //getters
  String get email => _email;
  String get password => _password;

  //setters
  void setEmail(String email){
    _email = email;
    notifyListeners();
  }

  void setPassword(String password){
    _password = password;
    notifyListeners();
  }




}