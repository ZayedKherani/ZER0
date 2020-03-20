import 'package:ZER0/Pages/Setup/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ZER0/Pages/Setup/signIn.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome')
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 7.5),
            child:
            Image.asset(
                'assets/The_Zero_Logo _(1).png'
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 7.5),
            child:
            RaisedButton(
              onPressed: (){
                navigateToSignIn();
              },
              child:
              Text('Sign in'),
            )
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 0.0),
              child:
              RaisedButton(
                onPressed: (){
                  navigateToSignUp();
                },
                child:
                Text('Sign up'),
              )
          ),
        ],
      ),
    );
  }

  void navigateToSignIn(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(title: 'ZER0 Sign in',),
            fullscreenDialog: true
        )
    );
  }

  void navigateToSignUp(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage(title: 'ZER0 Sign up',),
            fullscreenDialog: true
        )
    );
  }
}
