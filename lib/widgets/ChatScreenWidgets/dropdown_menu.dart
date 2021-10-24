import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuildDropDownMenu extends StatefulWidget {
  const BuildDropDownMenu({Key? key}) : super(key: key);

  @override
  _BuildDropDownMenuState createState() => _BuildDropDownMenuState();
}

class _BuildDropDownMenuState extends State<BuildDropDownMenu> {

  void clearChat() async{
    var collection = FirebaseFirestore.instance.collection('messages');
    var snapshot = await collection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  final _auth = FirebaseAuth.instance;
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: kCoralPink,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _value,
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.settings, color: kBubbleBlue,),
            ),
            iconSize: 25.0,
            elevation: 16,
            onChanged: (int? value){
              setState(() {
                _value = value!;
              });
            },
            items: [
              DropdownMenuItem(
                  child: TextButton(
                    child: Text('Settings', style: TextStyle(fontSize: 16.0, color: kBubbleBlue),),
                    onPressed: (){},
                  ),
                  value: 1,
              ),
              DropdownMenuItem(
                child: TextButton(
                  child: Text('Logout', style: TextStyle(fontSize: 16.0, color: kBubbleBlue),),
                  onPressed: (){
                    _auth.signOut();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                ),
                value: 2,
              ),
              DropdownMenuItem(
                child: TextButton(
                  child: Text('Clear Chat', style: TextStyle(fontSize: 16.0, color: kBubbleBlue),),
                  onPressed: (){
                      clearChat();
                  },
                ),
                value: 3,
              ),
            ]
        ),
      ),
    );
  }
}




