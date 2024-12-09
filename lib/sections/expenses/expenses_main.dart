import 'package:cas_house/providers/dasboard_provider.dart';
import 'package:cas_house/providers/home_provider.dart';
import 'package:cas_house/sections/expenses/add_new_expanses_popup.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ExpensesSectionMain extends StatefulWidget {
  const ExpensesSectionMain({super.key});

  @override
  State<ExpensesSectionMain> createState() => _ExpensesSectionMainState();
}

class _ExpensesSectionMainState extends State<ExpensesSectionMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpansesProvider>(
        builder: (context, dashboardProvider, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Expenses'),
            actions: <Widget>[
              const SizedBox(),
              IconButton(
                  icon: Icon(MdiIcons.plus),
                  tooltip: 'Add expenses',
                  onPressed: () =>
                      Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return AddNewExpensesPopup(
                              provider: Provider.of<ExpansesProvider>(context));
                        },
                      ))),
            ],
          ),
          body: ListView(
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
          ));
    });
  }
}
