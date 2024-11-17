import 'package:cas_house/providers/family_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FamilyMain extends StatefulWidget {
  const FamilyMain({super.key});

  @override
  State<FamilyMain> createState() => _FamilyMainState();
}

class _FamilyMainState extends State<FamilyMain> {
  @override
  // Consumer<DashboardProvider>(builder: (context, counter, child) {
  Widget build(BuildContext context) {
    return Consumer<FamilyProvider>(builder: (context, familyProvider, child) {
      return ListView(
        children: [
          Center(
            child: Text(
              "Family ${familyProvider.count}",
              style: TextStyle(color: Colors.black),
            ),
          ),
          IconButton(
              onPressed: () => {familyProvider.increment()},
              icon: Icon(Icons.plus_one)),
          IconButton(
              onPressed: () => {familyProvider.decrement()},
              icon: Icon(Icons.exposure_minus_1_outlined)),
        ],
      );
    });
  }
}
