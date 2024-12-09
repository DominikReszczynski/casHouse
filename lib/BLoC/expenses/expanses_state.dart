import 'package:equatable/equatable.dart';

abstract class ExpensesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExpensesInitial extends ExpensesState {
  final int count;

  ExpensesInitial({this.count = 0});

  @override
  List<Object?> get props => [count];
}