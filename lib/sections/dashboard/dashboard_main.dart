import 'package:cas_house/providers/dasboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardSectionMain extends StatefulWidget {
  const DashboardSectionMain({super.key});

  @override
  State<DashboardSectionMain> createState() => _DashboardSectionMainState();
}

class _DashboardSectionMainState extends State<DashboardSectionMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
      return ListView(
        children: [
          Center(
            child: Text(
              "Dasboard ${dashboardProvider.count}",
              style: TextStyle(color: Colors.black),
            ),
          ),
          IconButton(
              onPressed: () => {dashboardProvider.increment()},
              icon: Icon(Icons.plus_one)),
          IconButton(
              onPressed: () => {dashboardProvider.decrement()},
              icon: Icon(Icons.exposure_minus_1_outlined)),
        ],
      );
    });
  }
}
