import 'package:cas_house/BLoC/expenses/expanses_state.dart';
import 'package:cas_house/BLoC/expenses/expenses_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cas_house/models/expanses.dart';
import 'package:cas_house/services/expanses_services.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  ExpensesBloc() : super(ExpensesInitial()) {
    on<AddExpanseEvent>((event, emit) async {
      final result = await ExpansesServices().addExpanse(event.expanse);

      if (result != null) {
        final currentState = state as ExpensesInitial;
        final updatedList = List<Expanses>.from(currentState.expansesList)
          ..insert(0, result);

        emit(ExpensesInitial(
          expansesList: updatedList,
        ));

        // operacja się udała
        event.completer.complete(true);
      } else {
        // operacja się nie udała
        event.completer.complete(false);
      }
    });
  }
}
