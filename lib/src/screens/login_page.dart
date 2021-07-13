import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/widgets/create_account_form.dart';
import 'package:flutter_web_book_tracker/src/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreateAccountClicked = false;

//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xffb9c2d1),
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                'Sign In',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  SizedBox(
                      width: 300,
                      height: 350,
                      child: isCreateAccountClicked != true
                          ? LoginForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController)
                          : CreateAccountForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController)
                  ),
                  TextButton.icon(
                      icon: Icon(Icons.portrait_rounded),
                      style: TextButton.styleFrom(
                          primary: Color(0xfffd5b28),
                          textStyle:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                      onPressed: () {
                        setState(() {
                          if (!isCreateAccountClicked) {
                            isCreateAccountClicked = true;
                          } else
                            isCreateAccountClicked = false;

                          _passwordTextController.text = ''; // 초기화
                          _formKey = GlobalKey<FormState>(); // 키값 초기화
//                          print('isCreateAccountClicked: ${isCreateAccountClicked.toString()}');
//                          print('_formKey: ${_formKey.toString()}');
                        });
                      },
                      label: Text(isCreateAccountClicked
                          ? 'Already have an account?'
                          : 'Create Account'))
                ],
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xffb9c2d1),
                  ))
            ],
          )),
    );
  }
}
