import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/expanses.dart';
import 'package:cas_house/sections/expenses/expanse_tile.dart';
import 'package:flutter/material.dart';
import 'package:cas_house/providers/expanses_provider.dart';

class SummarizeOfExpensesPopup extends StatefulWidget {
  final String date;
  final ExpansesProvider expansesProvider;
  const SummarizeOfExpensesPopup({
    super.key,
    required this.expansesProvider,
    required this.date,
  });

  @override
  State<SummarizeOfExpensesPopup> createState() =>
      _SummarizeOfExpensesPopupState();
}

class _SummarizeOfExpensesPopupState extends State<SummarizeOfExpensesPopup> {
  bool isLoading = false;
  late Map<String, int> summarizedExpansesByGroup;

  void fun() async {
    Map<String, int> result = await widget.expansesProvider
        .fetchExpensesGroupedByCategory(widget.date, userId);
    setState(() {
      summarizedExpansesByGroup = result;
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    fun();
    setState(() {
      isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense history'),
      ),
      body: widget.expansesProvider.expansesListHistory.isEmpty
          ? const Center(child: Text('No expenses found.'))
          : ListView.builder(
              itemCount: widget.expansesProvider.expansesListHistory.length,
              itemBuilder: (context, outerIndex) {
                final Map<String, dynamic> historyItem =
                    widget.expansesProvider.expansesListHistory[outerIndex];
                final expanses = historyItem['expanses'];

                return Column(
                  children: [
                    expanses.isEmpty
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                historyItem['monthYear'],
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: expanses.length,
                                itemBuilder: (context, index) {
                                  final Expanses expanse =
                                      Expanses.fromMap(expanses[index]);
                                  return ExpenseTile(
                                    provider: widget.expansesProvider,
                                    expanse: expanse,
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                );
              },
            ),
    );
  }
}
