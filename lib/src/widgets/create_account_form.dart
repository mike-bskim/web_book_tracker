//import 'package:book_tracker/screens/main_screen.dart';
//import 'package:book_tracker/services/create_user.dart';
//import 'package:book_tracker/widgets/input_decoration.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/model/user.dart';
import 'package:flutter_web_book_tracker/src/screens/main_screen.dart';
import 'package:flutter_web_book_tracker/src/widgets/input_decoration.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
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
    return Form(
      key: _formKey,
      child: Column(children: [
        Text(
            'Please enter a valide email and a password that is at least 6 character.'),
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
              buildInputDecoration(label: 'password', hintText: '')
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                backgroundColor: Colors.amber,
                textStyle: TextStyle(fontSize: 18)),
            onPressed: () {
              print('Create Account');
              if (_formKey.currentState!.validate()) {
                String email = _emailTextController.text;
                String passWord = _passwordTextController.text;

                //john@me.com ['john', 'me.com']
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: email, password: passWord)
                    .then((value) {
                  if (value.user != null) {
                    String displayName = email.toString().split('@')[0];
                    createUser(displayName, context).then((value) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: email,
                          password: passWord)
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreenPage(),
                            ));
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
                    });
                  }
                });
              }
            },
            child: Text('Create Account'))
      ]),
    );
  }

  Future<void> createUser(String displayName, BuildContext context) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    MUser user = MUser(displayName: displayName, uid: uid);

    userCollection.add(user.toMap());
    return; // since it's a future void type
  }

}
