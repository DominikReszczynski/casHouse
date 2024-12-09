import 'package:equatable/equatable.dart';

abstract class ExpensesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IncrementEvent extends ExpensesEvent {}
class DecrementEvent extends ExpensesEvent {}