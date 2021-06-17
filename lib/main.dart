import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialisation,
      builder: (context, appSnapshot) {
        if (appSnapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Container(
                child: Center(
                  child: Text(
                    'Something went wrong!\n${appSnapshot.error.toString()}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          );
        }
        if (appSnapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Messenger',
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  return NavScreen();
                } else {
                  return AuthScreen();
                }
              },
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
