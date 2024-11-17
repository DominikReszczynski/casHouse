import 'package:cas_house/providers/shopping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingMain extends StatefulWidget {
  const ShoppingMain({super.key});

  @override
  State<ShoppingMain> createState() => _ShoppingMainState();
}

class _ShoppingMainState extends State<ShoppingMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingProvider>(
        builder: (context, shoppingProvider, child) {
      return ListView(
        children: [
          Center(
            child: Text(
              "Shopping ${shoppingProvider.count}",
              style: TextStyle(color: Colors.black),
            ),
          ),
          IconButton(
              onPressed: () => {shoppingProvider.increment()},
              icon: Icon(Icons.plus_one)),
          IconButton(
              onPressed: () => {shoppingProvider.decrement()},
              icon: Icon(Icons.exposure_minus_1_outlined)),
        ],
      );
    });
  }
}
