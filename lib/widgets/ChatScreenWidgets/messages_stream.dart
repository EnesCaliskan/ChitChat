import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'message_bubble.dart';

final _fireStore = FirebaseFirestore.instance;
class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key, required this.loggedInUser, required this.createdAt}) : super(key: key);
  final User loggedInUser;
  final Timestamp createdAt;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kCoralPink,
            ),
          );
        }
        final messages = snapshot.data!.docs;
        List<MessageBubble> messageBubbles = [];

        for(var message in messages){
          final messageText = message['text'];
          final messageSender = message['sender'];
          final messageTime = message['time'];

          final currentUser = loggedInUser.email;
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            time: messageTime,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}