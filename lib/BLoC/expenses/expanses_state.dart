import 'package:equatable/equatable.dart';
import 'package:cas_house/models/expanses.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();
  @override
  List<Object?> get props => [];
}

class ExpensesInitial extends ExpensesState {
  final List<Expanses> expansesList;

  ExpensesInitial({this.expansesList = const []});

  @override
  List<Object?> get props => [expansesList];
}
