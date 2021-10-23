import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try{
      final user = _auth.currentUser;
      if(user != null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch(e){
      print(e);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNavy,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: kCoralPink,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kCoralPink,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Logout', style: TextStyle(color: kBubbleBlue, fontSize: 16.0),),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout, color: kBubbleBlue,),
                        onPressed: (){
                            _auth.signOut();
                            Navigator.popAndPushNamed(context, WelcomeScreen.id);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextField(),
        ],
      ),
    );
  }
}
