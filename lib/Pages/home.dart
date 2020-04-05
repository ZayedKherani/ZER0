import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key, @required this.user}) : super(key: key);

  final FirebaseUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: <Widget>[

        ],
      ),
      body:
      StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('users').document(widget.user.uid).snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            return Text(
                'Loading...'
            );
            default:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 7.5),
                  child:
                  Image.asset(
                    'assets/The_Zero_Logo _(1).png',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 7.5),
                  child:
                  RaisedButton(
                    onPressed: (){},
                    child: Text(
                        'Checkout'
                    ),
                  )
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 7.5, 30.0, 7.5),
                    child:
                    RaisedButton(
                      onPressed: (){},
                      child: Text(
                          'Return'
                      ),
                    )
                ),
              ],
            );
          } // switch(snapshot.connectionState)
        }, // StreamBuilder builder:
      ),
    );
  }
}