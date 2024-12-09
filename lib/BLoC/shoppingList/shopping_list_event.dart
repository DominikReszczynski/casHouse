import 'package:cas_house/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ShoppingListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class IncrementEvent extends ShoppingListEvent {}

class DecrementEvent extends ShoppingListEvent {}

class AddItemEvent extends ShoppingListEvent {
  final ProductModel item;
  AddItemEvent(this.item);
  @override
  List<ProductModel?> get props => [item];
}

class UpdateIsBuyItemEvent extends ShoppingListEvent {
  final int index;
  UpdateIsBuyItemEvent(this.index);
  @override
  List<int> get props => [index];
}
