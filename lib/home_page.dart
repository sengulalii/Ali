import 'package:flutter/material.dart';
import 'page1.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Page1()));
              },
              child: Text('Sayfa 1 e git'),
            ),
          ),
        ],
      ),
    );
  }
}
