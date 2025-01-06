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

    // on<GetAnyUserExpanseEvent>((event, emit) async {
    //   final result = await ExpansesServices().getExpansesByAuthor();
    //   print(result);
    //   if (result != null) {
    //     final currentState = state as ExpensesInitial;
    //     final updatedList = List<Expanses>.from(currentState.expansesList)
    //       ..insert(0, result);

    //     emit(ExpensesInitial(
    //       expansesList: updatedList,
    //     ));

    //     // operacja się udała
    //     event.completer.complete(true);
    //   } else {
    //     // operacja się nie udała
    //     event.completer.complete(false);
    //   }
    // });

    on<GetAnyUserExpanseEvent>((event, emit) async {
      try {
        // Pobranie listy wydatków od autora
        final List<Expanses>? result =
            await ExpansesServices().getExpansesByAuthor();

        if (result != null && result.isNotEmpty) {
          // Pobranie aktualnego stanu
          final currentState = state as ExpensesInitial;

          // Aktualizacja listy wydatków
          final updatedList = List<Expanses>.from(currentState.expansesList)
            ..addAll(result);

          // Emitowanie nowego stanu z aktualizowaną listą
          emit(ExpensesInitial(
            expansesList: updatedList,
          ));

          // Operacja zakończona sukcesem
          event.completer.complete(true);
        } else {
          // Brak wyników lub błąd w danych
          event.completer.complete(false);
        }
      } catch (e) {
        print("Error fetching expanses: $e");
        // Obsługa błędu
        event.completer.complete(false);
      }
    });
  }
}
