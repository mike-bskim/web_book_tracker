import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/App.dart';

//import 'package:flutter_web_book_tracker/src/App.dart';
import 'package:flutter_web_book_tracker/src/screens/login_page.dart';
import 'package:flutter_web_book_tracker/src/screens/main_screen.dart';
import 'package:flutter_web_book_tracker/src/screens/page_not_found.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    User? firebaseUser = FirebaseAuth.instance.currentUser;
//    Widget widget;
//    if (firebaseUser != null) {
//      print('email: ' + firebaseUser.email.toString());
//      print('uid: ' + firebaseUser.uid.toString());
//      widget = MainScreenPage();
//    } else {
//      widget = LoginPage();
//    }

    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          initialData: null,
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
//        home: LoginPage(), //App(),
//        initialRoute: '/',
//        routes: {
//          '/': (context) => App(),
//          '/main': (context) => MainScreenPage(),
//          '/login': (context) => LoginPage(),
//        },

        initialRoute: '/',
        onGenerateRoute: (settings) {
          print('settings.name: ${settings.name}');
          return MaterialPageRoute(
            builder: (context) {
              return RouteController(settingName: settings.name);
            },
          );
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return PageNotFound();
            },
          );
        },

      ),
    );
  }
}


class RouteController extends StatelessWidget {
  final String? settingName;

  const RouteController({Key? key, this.settingName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userSignedIn = Provider.of<User?>(context) != null;

    final signedInGotoMain = userSignedIn && settingName == '/main'; // they are good to go!
    final notSignedInGotoMain = !userSignedIn && settingName == '/main'; // not signed in user trying to to the mainPage

    if (settingName == '/') {
      return App();
    } else if (settingName == '/login' || notSignedInGotoMain) {
      return LoginPage();
    } else if (signedInGotoMain) {
      return MainScreenPage();
    } else {
      return PageNotFound();
    }
  }
}