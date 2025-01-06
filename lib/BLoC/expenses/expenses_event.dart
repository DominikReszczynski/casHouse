import 'dart:async';

import 'package:cas_house/models/expanses.dart';
import 'package:equatable/equatable.dart';

abstract class ExpensesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddExpanseEvent extends ExpensesEvent {
  final Expanses expanse;
  final Completer<bool> completer;

  AddExpanseEvent(this.expanse, this.completer);

  @override
  List<Object> get props => [expanse];
}

class GetAnyUserExpanseEvent extends ExpensesEvent {
  final Completer<bool> completer;
  GetAnyUserExpanseEvent(this.completer);
}
