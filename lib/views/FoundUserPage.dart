import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FoundUserPage extends StatefulWidget {
  final String name;


  FoundUserPage({required this.name});

  @override
  _FoundUserPageState createState() => _FoundUserPageState();
}

class _FoundUserPageState extends State<FoundUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Found User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Found User:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              widget.name, // ใช้ค่า name ที่รับมาจาก constructor
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
