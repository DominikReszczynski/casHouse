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
        appBar: AppBar(title: Text('Backend Test')),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: fetchMessage,
          child: Text("Fetch Message from Backend"),
        ),
      ],
    );
  }
}
