import 'package:cas_house/sections/expenses/expanse_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cas_house/models/expanses.dart';
import 'package:cas_house/providers/expanses_provider.dart';
import 'package:cas_house/sections/expenses/add_new_expanses_popup.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ExpensesSectionMain extends StatefulWidget {
  const ExpensesSectionMain({super.key});

  @override
  State<ExpensesSectionMain> createState() => _ExpensesSectionMainState();
}

class _ExpensesSectionMainState extends State<ExpensesSectionMain> {
  bool isLoading = false;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Provider.of<ExpansesProvider>(context, listen: false).fetchExpenses();
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expansesProvider = Provider.of<ExpansesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Divider(),
        ),
        title: const Text('Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.plus),
            tooltip: 'Add expenses',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddNewExpensesPopup(
                  // Przekazywanie providera do okna dodawania
                  expensesProvider: expansesProvider,
                ),
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : expansesProvider.expansesList.isEmpty
              ? const Center(child: Text('No expenses found.'))
              : ListView.builder(
                  itemCount: expansesProvider.expansesList.length,
                  itemBuilder: (context, index) {
                    final item = expansesProvider.expansesList[index];
                    return ExpenseTile(
                      provider: expansesProvider,
                      expanse: item,
                    );
                  },
                ),
    );
  }
}
