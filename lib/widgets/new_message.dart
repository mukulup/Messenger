import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String roomName;

  const NewMessage({Key key, @required this.roomName}) : super(key: key);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance
        .collection('Room')
        .doc('${widget.roomName}')
        .collection('Chat')
        .add({
      'text': _enteredMessage,
      'username': userData['username'],
      'email': userData['email'],
      'createdAt': Timestamp.fromMillisecondsSinceEpoch(
        Duration.microsecondsPerSecond,
      ),
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      margin: const EdgeInsets.only(
        top: 8.0,
      ),
      padding: const EdgeInsets.only(
          top: 8.0, bottom: 20.0, left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            cursorColor: Colors.white,
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
                labelText: 'Send a message...', focusColor: Colors.yellow),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
