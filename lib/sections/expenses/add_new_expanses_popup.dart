import 'package:flutter/material.dart';

class AddNewExpansesPopup extends StatefulWidget {
  const AddNewExpansesPopup({super.key});

  @override
  State<AddNewExpansesPopup> createState() => _AddNewExpansesPopupState();
}

class _AddNewExpansesPopupState extends State<AddNewExpansesPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new expanses'),
      ),
      body: const Center(
        child: Text(
          'This is the next page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
