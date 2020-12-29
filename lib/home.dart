import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final DatabaseReference = FirebaseDatabase.instance.reference();
  //final FirebaseAuth auth = FirebaseAuth.instance;

  // Variable for Realtime Database
  final textSending = TextEditingController();
  final textReceiving = TextEditingController();

  // Variable for Authentification
  final name_auth = TextEditingController();
  final email_auth = TextEditingController();
  final password_auth = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireBase Test'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 30,
          bottom: 100,
          left: 15,
          right: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /********** Authentification **********/
              Container(
                child: Text(
                  'Authentification',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 10),
              ),
              Container(
                //color: Colors.blue[900],
                //height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[900],
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        //color: Colors.red[100], // debug
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Name',
                          ),
                          controller: name_auth,
                        ),
                      ),
                      Container(
                        //color: Colors.blue[100], // debug
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                          controller: email_auth,
                        ),
                      ),
                      Container(
                        //color: Colors.green[100], // debug
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                          ),
                          controller: password_auth,
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          onPressed: () {
                            //sign_up();
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue[900],
                        ),
                        alignment: Alignment.center,
                        //color: Colors.red[100],
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                      ),
                    ],
                  ),
                ),
              ),
              /********** Réception/Envoi de données **********/
              Container(
                child: Text(
                  'Réception / Envoi de données',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 30, bottom: 10),
              ),
              Container(
                //height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[900],
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      //color: Colors.blue[100], // debug
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Text sending',
                        ),
                        controller: textSending,
                      ),
                    ),
                    Container(
                      //color: Colors.blue[100], // debug
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Received text',
                        ),
                        readOnly: true,
                        controller: textReceiving,
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          refresh();
                        },
                        child: Text(
                          'Refresh',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue[900],
                      ),
                      alignment: Alignment.center,
                      //color: Colors.red[100],
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    DatabaseReference.child("Sending data").set({
      'Text Sending': textSending.text,
    });
    DatabaseReference.child("Receiving data")
        .child("Text Receiving")
        .once()
        .then(
      (DataSnapshot snapshot) {
        //print(snapshot.value);
        setState(() {
          textReceiving.text = snapshot.value;
        });
      },
    );
  }

  /*
  void sign_up() {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email_auth.text,
        password: password_auth.text,
      );
    } catch (e) {
      print(e);
    }
  }
  */
}
