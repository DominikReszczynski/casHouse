import 'package:auto_size_text/auto_size_text.dart';
import 'package:cas_house/main_global.dart';
import 'package:cas_house/providers/home_provider.dart';
import 'package:cas_house/sections/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class HomeSectionMain extends StatefulWidget {
  const HomeSectionMain({super.key});

  @override
  State<HomeSectionMain> createState() => _HomeSectionMainState();
}

class _HomeSectionMainState extends State<HomeSectionMain> {
  List<Map<String, dynamic>> widgetContent = [
    // {
    //   'icon': Icon(MdiIcons.cashMultiple),
    //   'child': const Text('cash'),
    //   'openFunction': () => {changeChosenSection(Sections.Dashboard)}
    // },
    // {
    //   'icon': Icon(MdiIcons.cart),
    //   'child': const Text('shopping'),
    //   'openFunction': () => {changeChosenSection(Sections.Shopping)}
    // },
    // {
    //   'icon': Icon(MdiIcons.humanMaleFemaleChild),
    //   'child': const Text('family'),
    //   'openFunction': () => {changeChosenSection(Sections.Family)}
    // },
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return ListView(
        shrinkWrap: true,
        children: [
          const AutoSizeText(
            "Hi, Dominik",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
          const Divider(),
          Center(
            child: Text(
              "Dasboard ${homeProvider.count}",
              style: TextStyle(color: Colors.black),
            ),
          ),
          IconButton(
              onPressed: () => {homeProvider.increment()},
              icon: Icon(Icons.plus_one)),
          IconButton(
              onPressed: () => {homeProvider.decrement()},
              icon: Icon(Icons.exposure_minus_1_outlined)),
          for (Map data in widgetContent)
            HomeWidget(
                icon: data['icon'],
                openFunction: data['openFunction'],
                child: data['child']),
        ],
      );
    });
  }
}
