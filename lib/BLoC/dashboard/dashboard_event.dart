import 'package:equatable/equatable.dart';

// Definiujemy eventy dla BLoC
abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class IncrementEvent extends DashboardEvent {}

class DecrementEvent extends DashboardEvent {}