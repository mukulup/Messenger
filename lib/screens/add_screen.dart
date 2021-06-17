import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  var roomName = '';
  var roomCategory = '';

  void _tryAdd() {
    _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    try {
      FirebaseFirestore.instance.collection('Room').doc('$roomName').set(
          {'room': '$roomName', 'category': '$roomCategory', 'home': false});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Room Created Successfully',
          ),
        ),
      );
      _formKey.currentState.reset();
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err.toString(),
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          'Create Room',
          style: TextStyle(
              color: Colors.teal.shade200,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
      ),
      body: Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (newValue) {
                      roomName = newValue;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a unique room name';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(labelText: 'Room Name'),
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      roomCategory = newValue;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a room category';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.greenAccent.shade400)),
                      onPressed: _tryAdd,
                      child: Text('Add User')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
