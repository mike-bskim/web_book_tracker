import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/App.dart';
import 'package:flutter_web_book_tracker/src/screens/login_page.dart';
import 'package:flutter_web_book_tracker/src/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget widget;
    if (firebaseUser != null) {
      print('email: ' + firebaseUser.email.toString());
      print('uid: ' + firebaseUser.uid.toString());
      widget = MainScreenPage();
    } else {
      widget = LoginPage();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget, //App(),
    );
  }
}

