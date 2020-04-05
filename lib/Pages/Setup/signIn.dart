import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:ZER0/Pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child:
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 7.5),
                  child:
                  Image.asset(
                    'assets/The_Zero_Logo _(1).png',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 7.5),
                  child:
                  TextFormField(
                    controller: email,
                    // ignore: missing_return
                    validator: (input){
                      if(input.isEmpty){
                        return 'Email is required';
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.blue,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        labelText: 'Email'
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 30.0),
                  child:
                  TextFormField(
                    controller: password,
                    // ignore: missing_return
                    validator: (input){
                      if(input.isEmpty){
                        return 'Password is required';
                      } else if(input.length < 8){
                        return 'Password is too short';
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.blue,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        labelText: 'Password'
                    ),
                    obscureText: true,
                  ),
                ),
                RaisedButton(
                  onPressed: signIn,
                  child: Text(
                      'Sign in'
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        FirebaseUser user = (
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                email: email.text.toLowerCase(), password: password.text
            )
        ).user;
        if(user.isEmailVerified){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                content: Text(
                  "Email Not Verified"
                )
              );
            }
          );
        }
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              user: user
            ),
          ),
        );
      } catch (e){
        print(e.message);
      }
    }
  }
}