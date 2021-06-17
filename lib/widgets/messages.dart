import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  final String roomName;

  const Messages({Key key, @required this.roomName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Room')
            .doc('$roomName')
            .collection('Chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data.docs;

          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              message: chatDocs[index]['text'],
              isMe: chatDocs[index]['email'] == user.email,
              username: chatDocs[index]['username'],
              key: ValueKey(chatDocs[index].id),
            ),
          );
        });
  }
}
