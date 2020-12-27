import 'package:flutter/material.dart';

class Record extends StatefulWidget {
  @override
  RecordState createState() => RecordState();
}

class RecordState extends State<Record> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record'),
      ),
    );
  }
}
