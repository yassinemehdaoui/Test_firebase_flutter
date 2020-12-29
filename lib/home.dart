import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final DatabaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Variable for Realtime Database
  final textSending = TextEditingController();
  final textReceiving = TextEditingController();

  // Variable for create account
  final name_creation = TextEditingController();
  final email_creation = TextEditingController();
  final password_creation = TextEditingController();

  // Variable for Authentification
  final email_auth = TextEditingController();
  final password_auth = TextEditingController();

  String status_creation;
  String status_authentification;

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
              /********** Creation de compte **********/
              Container(
                child: Text(
                  'Création de compte',
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
                          controller: name_creation,
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
                          controller: email_creation,
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
                          controller: password_creation,
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text('status : $status_creation'),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          onPressed: () {
                            sign_up();
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
                padding: EdgeInsets.only(top: 30, bottom: 10),
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
                        child: Center(
                          child: Text('status : $status_authentification'),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          onPressed: () {
                            sign_in();
                          },
                          child: Text(
                            'Sign in',
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

  void sign_up() {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email_creation.text,
        password: password_creation.text,
      );
      print('==> Account created');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void sign_in() {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_auth.text,
        password: password_auth.text,
      );
      status_authentification = 'Account Signed in successfully';
      print('==> Account Signed in successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        status_authentification = e.code;
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        status_authentification = e.code;
        print('Wrong password provided for that user.');
      }
    }
  }
}
