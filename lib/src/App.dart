import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/screens/login_page.dart';
import 'package:hexcolor/hexcolor.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircleAvatar(
//        backgroundColor: Color(0xfff5f6f8),
        backgroundColor: HexColor('#e6e7e9'),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//          Spacer(),
          Text(
            'BookTracker',
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 15,
          ),
          Text('"Read. Change. Yourself"',
              style: TextStyle(color: Colors.black26, fontWeight: FontWeight.bold, fontSize: 29)),
          SizedBox(
            height: 50,
          ),
          TextButton.icon(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color(0xff69639f),
                  textStyle: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              icon: Icon(Icons.login_rounded),
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sign in to get started'),
              )),
//          Spacer()
        ]),
      ),
    );
  }
}
