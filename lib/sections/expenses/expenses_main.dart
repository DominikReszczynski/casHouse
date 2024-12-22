import 'package:cas_house/BLoC/expenses/expenses_bloc.dart';
import 'package:cas_house/BLoC/expenses/expenses_event.dart';
import 'package:cas_house/BLoC/expenses/expanses_state.dart';
import 'package:cas_house/models/expanses.dart';
import 'package:cas_house/sections/expenses/add_new_expanses_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ExpensesSectionMain extends StatefulWidget {
  const ExpensesSectionMain({super.key});

  @override
  State<ExpensesSectionMain> createState() => _ExpensesSectionMainState();
}

class _ExpensesSectionMainState extends State<ExpensesSectionMain> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpensesBloc(),
      child: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<ExpensesBloc>(context);

          List<Expanses> expansesList = [];
          if (state is ExpensesInitial) {
            expansesList = state.expansesList;
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Expenses'),
              actions: <Widget>[
                const SizedBox(),
                IconButton(
                  icon: Icon(MdiIcons.plus),
                  tooltip: 'Add expenses',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddNewExpensesPopup(
                        expensesBloc: context.read<ExpensesBloc>(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<ExpensesBloc, ExpensesState>(
              builder: (context, state) {
                if (state is ExpensesInitial) {
                  return ListView.builder(
                    itemCount: expansesList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < expansesList.length) {
                        final item = expansesList[index];
                        return Text(item.name);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
