import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final bool isHome;
  final String roomName;
  final String roomCategory;

  const RoomCard(
      {Key key,
      @required this.isHome,
      @required this.roomName,
      @required this.roomCategory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    void addToHome() async {
      try {
        await FirebaseFirestore.instance
            .collection('Room')
            .doc('$roomName')
            .set({
          'room': '$roomName',
          'category': '$roomCategory',
          'home': true
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Room added to Home')));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'An error occured please try again',
          style: TextStyle(color: Theme.of(context).errorColor),
        )));
      }
    }

    // void removeFromHome() async {
    //   try {
    //     await FirebaseFirestore.instance
    //         .collection('Room')
    //         .doc('$roomName')
    //         .set({
    //       'room': '$roomName',
    //       'category': '$roomCategory',
    //       'home': false
    //     });
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text('Room removed from Home')));
    //   } catch (error) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text(
    //       'An error occured please try again',
    //       style: TextStyle(color: Theme.of(context).errorColor),
    //     )));
    //   }
    // }

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(
          roomName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(roomCategory),
        trailing: isHome
            ? null
            // ? IconButton(
            //     onPressed: removeFromHome,
            //     icon: Icon(Icons.arrow_back),
            //     color: Theme.of(context).errorColor,
            //   )
            : IconButton(
                onPressed: addToHome,
                icon: Icon(Icons.add),
                color: Colors.greenAccent.shade400,
              ),
      ),
    );
  }
}
