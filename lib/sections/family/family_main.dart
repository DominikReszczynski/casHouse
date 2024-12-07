import 'package:cas_house/providers/family_provider.dart';
import 'package:cas_house/widgets/section_title.dart';
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
        children: const [
          SectionTitle(
            title: "FAMILY",
          )
        ],
      );
    });
  }
}
