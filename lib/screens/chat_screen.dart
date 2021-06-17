import 'package:flutter/material.dart';
import 'package:messenger/widgets/messages.dart';
import 'package:messenger/widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  final String roomName;

  const ChatScreen({Key key, @required this.roomName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.teal,
          ),
        ),
        title: Text(
          '$roomName',
          style: TextStyle(color: Colors.teal),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: Messages(roomName: roomName)),
            NewMessage(
              roomName: roomName,
            ),
          ],
        ),
      ),
    );
  }
}
