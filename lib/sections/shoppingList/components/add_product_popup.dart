import 'package:cas_house/BLoC/shoppingList/shopping_list_bloc.dart';
import 'package:cas_house/BLoC/shoppingList/shopping_list_event.dart';
import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/product_model.dart';
import 'package:cas_house/sections/shoppingList/components/category_and_priority_input.dart';
import 'package:cas_house/sections/shoppingList/components/price_and_currency_input.dart';
import 'package:cas_house/sections/shoppingList/components/quantity_and_unit_input.dart';
import 'package:flutter/material.dart';

class AddProductPopUp extends StatefulWidget {
  final ShoppingListBloc bloc;
  const AddProductPopUp({super.key, required this.bloc});

  @override
  State<AddProductPopUp> createState() => _AddProductPopUpState();
}

class _AddProductPopUpState extends State<AddProductPopUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _producerController = TextEditingController();
  final TextEditingController _shopController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _selectedUnit = 'kg';
  String _selectedCurrency = 'USD';
  String _selectedCategory = 'Groceries';
  String _selectedPriority = 'Low';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Add Item to Shopping List",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _producerController,
              decoration: const InputDecoration(
                labelText: "Producer",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _shopController,
              decoration: const InputDecoration(
                labelText: "Shop",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            QuantityAndUnitInput(
              onQuantityChanged: (double quantity) {
                _quantityController.text = quantity.toString();
              },
              onUnitChanged: (String unit) {
                _selectedUnit = unit;
              },
            ),
            SizedBox(
              height: 16,
            ),
            PriceAndCurrencyInput(
              onPriceChanged: (double price) {
                _priceController.text = price.toString();
              },
              onCurrencyChanged: (String currency) {
                _selectedCurrency = currency;
              },
            ),
            SizedBox(
              height: 16,
            ),
            CategoryAndPriorityInput(
              onCategoryChanged: (String category) {
                _selectedCategory = category;
              },
              onPriorityChanged: (String priority) {
                _selectedPriority = priority;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  final newProduct = ProductModel(
                    name: _nameController.text,
                    producent: _producerController.text,
                    shop: _shopController.text,
                    amount: parseDouble(_quantityController.text),
                    unit: _selectedUnit,
                    price: parseDouble(_priceController.text),
                    currency: _selectedCurrency,
                    category: _selectedCategory,
                    date: DateTime.now(),
                    isBuy: false,
                    priority: _selectedPriority,
                  );
                  print(newProduct);
                  widget.bloc.add(AddItemEvent(newProduct));
                  Navigator.pop(context); // Close modal
                }
              },
              child: const Text("Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}
