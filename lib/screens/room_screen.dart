import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/widgets/room_card.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.teal,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Rooms',
          style: TextStyle(
              color: Colors.teal.shade200,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Room').snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> roomSnapshot) {
            if (roomSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final roomDocs = roomSnapshot.data.docs;
            return ListView.builder(
                itemCount: roomDocs.length,
                itemBuilder: (ctx, index) => RoomCard(
                    isHome: false,
                    roomName: roomDocs[index].id,
                    roomCategory: roomDocs[index]['category']));
          }),
    );
  }
}
