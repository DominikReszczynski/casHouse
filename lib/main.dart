import 'package:cas_house/nav_bar/nav_bar_main.dart';
import 'package:cas_house/sections/section_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: HelloButton()),
      ),
    );
  }
}

class HelloButton extends StatefulWidget {
  @override
  _HelloButtonState createState() => _HelloButtonState();
}

class _HelloButtonState extends State<HelloButton> {
  String message = "Press the button to fetch data";

  Future<void> fetchMessage() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/api/hello'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          message = data['message'];
        });
      } else {
        setState(() {
          message = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SectionMain(),
        NavBarMain()
        // Text(message),
        // SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: fetchMessage,
        //   child: Text("Fetch Message from Backend"),
        // ),
      ],
    );
  }
}
