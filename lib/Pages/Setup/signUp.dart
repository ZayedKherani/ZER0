import 'package:ZER0/Pages/Setup/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String _email, _password, _password2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  var email = TextEditingController();
  var password = TextEditingController();
  var password2 = TextEditingController();

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
                      onSaved: (input) => _email = input,
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
                      onSaved: (input) => _password = input,
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
                    padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 30.0),
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
                      onSaved: (input) => _password2 = input,
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
                  RaisedButton(
                    onPressed: signUp,
                    child: Text(
                        'Sign up'
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )
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
              email: email.text, password: password.text
          )
        ).user;
        user.sendEmailVerification();
        //TODO: Display email sent
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              title: 'ZER0 Sign in',
            ),
          ),
        );
      } catch (e){
        print(e.message);
      }
    }
  }
}
