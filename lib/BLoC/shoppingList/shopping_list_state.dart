import 'package:cas_house/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ShoppingListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShoppingListInitial extends ShoppingListState {
  final int count;
  final List<ProductModel> shoppingListItems;

  ShoppingListInitial({
    this.count = 1,
    this.shoppingListItems = const [],
  });

  @override
  List<Object?> get props => [count, shoppingListItems];
}
