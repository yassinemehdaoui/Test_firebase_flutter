import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
  String _email, _password;

  // Variable for Authentification
  String _emailAuth, _passwordAuth;

  String status_creation, status_authentification;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireBase Test'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        //color: Colors.red[100], // debug
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
                //color: Colors.cyan[100], // debug
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an email';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Longer password please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                          ),
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: signUp,
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue[900],
                        ),
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
                //height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[900],
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                /*
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an email';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Longer password please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                          ),
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: signIn,
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),
                */
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
                      child: TextFormField(
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
                      child: TextFormField(
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

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      } catch (e) {
        print(e.message);
      }
    }
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
}
