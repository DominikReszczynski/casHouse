import 'package:equatable/equatable.dart';

// Definiujemy stan aplikacji
abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  final int count;

  DashboardInitial({this.count = 0});

  @override
  List<Object?> get props => [count];
}
