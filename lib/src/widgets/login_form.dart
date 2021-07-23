//import 'package:book_tracker/screens/main_screen.dart';
//import 'package:book_tracker/widgets/input_decoration.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/screens/main_screen.dart';
import 'package:flutter_web_book_tracker/src/widgets/input_decoration.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  })  : _formKey = formKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
//    GlobalKey _scaffold = GlobalKey();
    return Form(
      key: _formKey,
      child: Column(children: [
        Padding(padding: EdgeInsets.only(top: 32.0)),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              return value!.isEmpty ? 'Please add an email' : null;
            },
            controller: _emailTextController,
            decoration: buildInputDecoration(
                label: 'Enter email', hintText: 'john@me.com'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
              validator: (value) {
                return value!.isEmpty ? 'Enter password' : null;
              },
              controller: _passwordTextController,
              obscureText: true,
              decoration:
              buildInputDecoration(label: 'password', hintText: '')),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
            child: Text('Sign In'),
            style: TextButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                backgroundColor: Colors.amber,
                textStyle: TextStyle(fontSize: 18)),
            onPressed: () {
              print('Sign In');
              if (_formKey.currentState!.validate()) {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text)
                    .then((value) {
//                      print('login_form.dart: ' + value.user.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreenPage()));
                }).catchError((onError) {
                  // ignore: invalid_return_type_for_catch_error
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Oops!'),
                        content: Text('${onError.message}'),
                      );
                    },
                  );
                });
              }
            }
        )
      ]),
    );
  }
}
