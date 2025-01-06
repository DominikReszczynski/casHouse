import 'package:cas_house/BLoC/shoppingList/shopping_list_event.dart';
import 'package:cas_house/BLoC/shoppingList/shopping_list_state.dart';
import 'package:cas_house/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final List<ProductModel> _shoppingList = [];
  ShoppingListBloc() : super(ShoppingListInitial()) {
    on<AddItemEvent>((event, emit) {
      final currentState = state as ShoppingListInitial;

      // Tworzymy nową listę i dodajemy nowy element na początek
      final updatedList =
          List<ProductModel>.from(currentState.shoppingListItems)
            ..insert(0, event.item);

      // Emitujemy nowy stan z uaktualnioną listą
      emit(ShoppingListInitial(
        count: updatedList.length, // Aktualizujemy licznik
        shoppingListItems:
            updatedList, // Uaktualniona lista z nowym elementem na początku
      ));
    });

    on<UpdateIsBuyItemEvent>((event, emit) {
      final currentState = state as ShoppingListInitial;

      // Tworzymy nową listę z zaktualizowanym elementem
      final updatedList =
          List<ProductModel>.from(currentState.shoppingListItems);
      final updatedItem = updatedList[event.index].copyWith(
        isBuy: !updatedList[event.index].isBuy,
      );
      updatedList[event.index] = updatedItem;

      // Emitujemy nowy stan
      emit(ShoppingListInitial(
        count: updatedList.length,
        shoppingListItems: updatedList,
      ));
    });
  }
}
