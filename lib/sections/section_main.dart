import 'package:flutter/material.dart';

class SectionMain extends StatefulWidget {
  const SectionMain({super.key});

  @override
  State<SectionMain> createState() => _SectionMainState();
}

class _SectionMainState extends State<SectionMain> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(color: Colors.red),
        child: Text("fisrst section"),
      ),
    );
  }
}
