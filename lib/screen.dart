import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_firebase/record.dart';

class Screen extends StatefulWidget {
  @override
  ScreenState createState() => ScreenState();
}

class ScreenState extends State<Screen> {
  final DatabaseReference = FirebaseDatabase.instance.reference();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase connect'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: RaisedButton(
                onPressed: () {
                  createRecord();
                },
                child: Text('Create Record'),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  getData();
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Record()),
                  );
                  */
                },
                child: Text('View Record'),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  updateData();
                },
                child: Text('Update Record'),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  deleteData();
                },
                child: Text('Delete Record'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createRecord() {
    DatabaseReference.child("1").set({
      'title': 'Mastering EJB',
      'description': 'Programming Guide for J2EE'
    });
    DatabaseReference.child("2").set({
      'title': 'Flutter in Action',
      'decription': 'Complete Programming Guide to learn Flutter'
    });
  }

  void getData() {
    DatabaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData() {
    DatabaseReference.child("1").update({
      'description': 'J2EE complete Reference',
    });
  }

  void deleteData() {
    DatabaseReference.child("1").remove();
  }
}
