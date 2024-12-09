import 'package:cas_house/BLoC/expenses/expanses_state.dart';
import 'package:cas_house/BLoC/expenses/expenses_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  ExpensesBloc() : super(ExpensesInitial()) {
    
    on<IncrementEvent>(((event, emit) {
      final currentState = state as ExpensesInitial;
      emit(ExpensesInitial(count: currentState.count + 1));
    }));

    on<DecrementEvent>(
      (event, emit) {
        final currentState = state as ExpensesInitial;
        emit(ExpensesInitial(count: currentState.count - 1));
      },
    );
  }
}
