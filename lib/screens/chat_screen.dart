import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:chat_app/widgets/ChatScreenWidgets/dropdown_menu.dart';
import 'package:chat_app/widgets/ChatScreenWidgets/messages_stream.dart';
import 'package:chat_app/widgets/ChatScreenWidgets/text_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final messageTextController = TextEditingController();

  late String messageText;

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: BuildDropDownMenu(),
                      ),
                      /*
                      IconButton(
                        icon: Icon(Icons.logout, color: kBubbleBlue,),
                        onPressed: (){
                            _auth.signOut();
                            Navigator.popAndPushNamed(context, WelcomeScreen.id);
                        },
                      ),
                       */
                    ],
                  ),
                ),
              ],
            ),
          ),
          MessagesStream(
            createdAt: Timestamp.now(),
            loggedInUser: loggedInUser,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value){
                messageText = value;
              },
              controller: messageTextController,
              style: TextStyle(color: kBubbleBlue, fontSize: 16.0),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(
                enabledBorder: buildOutlineInputBorder(),
                focusedBorder: buildOutlineInputBorder(),
                prefixIcon: IconButton(
                  icon: Icon(Icons.emoji_emotions, color: kCoralPink,),
                  onPressed: (){
                    //emoji
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: kCoralPink,),
                  onPressed: (){
                      messageTextController.clear();
                      _fireStore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'time' : Timestamp.now(),
                        });
                  }),
              ),
            ),
          ),
        ],
      ),
    );
  }


}






