import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    // Obsługa IncrementEvent
    on<IncrementEvent>((event, emit) {
      final currentState = state as DashboardInitial;
      emit(DashboardInitial(count: currentState.count + 1));
    });

    // Obsługa DecrementEvent
    on<DecrementEvent>((event, emit) {
      final currentState = state as DashboardInitial;
      emit(DashboardInitial(count: currentState.count - 1));
    });
  }
}
