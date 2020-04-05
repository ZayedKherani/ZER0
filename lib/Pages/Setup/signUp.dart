import 'package:ZER0/Pages/Setup/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'TaCPP/PP.dart';
import 'TaCPP/TaC.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TapGestureRecognizer _recognizer;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  var email = TextEditingController();
  var password = TextEditingController();
  var password2 = TextEditingController();

  @override
  void initState(){
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(
            title: 'ZER0 Sign in',
          ),
        ),
      );
      print('pressed');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
      Scaffold(
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
                        'assets/The_Zero_Logo _(1).png'
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
                    padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 7.5),
                    child:
                    TextFormField(
                      controller: password,
                      // ignore: missing_return
                      validator: (input){
                        if(input.isEmpty){
                          return 'Password is required';
                        } else if(input.length < 8){
                          return 'Password is too short';
                        } else if (password2.text.toString() != password.text.toString()){
                          return 'Passwords do not match';
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
                  Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 7.5),
                    child:
                    TextFormField(
                      controller: password2,
                      // ignore: missing_return
                      validator: (input){
                        if(input.isEmpty){
                          return 'Password is required';
                        } else if(input.length < 8){
                          return 'Password is too short';
                        } else if (password2.text.toString() != password.text.toString()){
                          return 'Passwords do not match';
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.blue,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
                          labelText: 'Confirm Password'
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 7.5),
                    child:
                    RaisedButton(
                      onPressed: signUp,
                      child: Text(
                          'Sign up'
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 7.5),
                    child:
                    Text('By Signing up, you agree to the ZER0 Terms and Conditions and Privacy Policy')
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(30.0, 7.5, 7.5, 7.5),
                        child:
                        RaisedButton(
                          onPressed: ToC,
                          child: Text(
                              'Terms and Conditions'
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(7.5, 7.5, 30.0, 7.5),
                        child:
                        RaisedButton(
                          onPressed: RO,
                          child: Text(
                              'Privacy Policy'
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }

  // ignore: non_constant_identifier_names
  void ToC() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TaC(),
        fullscreenDialog: true
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void RO() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => PP(),
          fullscreenDialog: true
      ),
    );
  }

  void signUp() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        FirebaseUser user = (
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: email.text.toLowerCase(), password: password.text
          )
        ).user;
        user.sendEmailVerification();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Check(user: user,)));
        /*Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              title: 'ZER0 Sign in',
            ),
          ),
        );*/
      } catch (e){
        print(e.message);
      }
    }
  }
}


class Check extends StatefulWidget {
  final user;

  const Check({Key key, this.user}) : super(key: key);

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  void signUp(){
    if(widget.user.isEmailVerified){
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(
            title: 'ZER0 Sign in',
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("ZER0 Email Verification"),
            content: new Text("Please verify your email."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification Sent'),
      ),
      body:
      ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(7.5, 250.0, 7.5, 7.5),
            child:
            Column(
              children: <Widget>[
                Text('Email verification sent to ${widget.user.email}'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 7.5),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  onPressed: signUp,
                  child: Text(
                      'Sign In'
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
