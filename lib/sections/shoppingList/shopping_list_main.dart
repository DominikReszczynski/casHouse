import 'package:cas_house/BLoC/shoppingList/shopping_list_bloc.dart';
import 'package:cas_house/BLoC/shoppingList/shopping_list_event.dart';
import 'package:cas_house/BLoC/shoppingList/shopping_list_state.dart';
import 'package:cas_house/models/product_model.dart';
import 'package:cas_house/sections/shoppingList/components/add_product_popup.dart';
import 'package:cas_house/sections/shoppingList/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ShoppingMain extends StatefulWidget {
  const ShoppingMain({super.key});

  @override
  State<ShoppingMain> createState() => _ShoppingMainState();
}

class _ShoppingMainState extends State<ShoppingMain> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShoppingListBloc(),
      child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<ShoppingListBloc>(context);

          List<ProductModel> shoppingList = [];
          if (state is ShoppingListInitial) {
            shoppingList = state.shoppingListItems;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("SHOPPING LIST"),
              actions: [
                IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: Builder(
                              builder: (context) {
                                return AddProductPopUp(bloc: bloc);
                              },
                            ),
                          )),
                  icon: Icon(MdiIcons.plus),
                  iconSize: 30,
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: shoppingList.length,
              itemBuilder: (context, index) {
                return PrductTile(
                  product: shoppingList[index],
                  updateIsBuy: () => bloc.add(UpdateIsBuyItemEvent(index)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
