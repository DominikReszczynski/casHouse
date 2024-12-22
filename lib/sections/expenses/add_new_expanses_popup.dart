import 'dart:async';

import 'package:cas_house/BLoC/expenses/expenses_bloc.dart';
import 'package:cas_house/BLoC/expenses/expenses_event.dart';
import 'package:cas_house/models/expanses.dart';
import 'package:cas_house/sections/expenses/expanses_global.dart';
import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Definicja enum ExpenseCategory
enum ExpenseCategory {
  food,
  housing,
  utilities,
  transportation,
  healthcare,
  entertainment,
  education,
  personalCare,
  clothing,
  savings,
  debtRepayment,
  insurance,
  miscellaneous,
}

// Widget AddNewExpensesPopup
class AddNewExpensesPopup extends StatefulWidget {
  final ExpensesBloc expensesBloc;
  const AddNewExpensesPopup({super.key, required this.expensesBloc});

  @override
  State<AddNewExpensesPopup> createState() => _AddNewExpensesPopupState();
}

class _AddNewExpensesPopupState extends State<AddNewExpensesPopup> {
  // Lista przechowująca dodane wydatki
  List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj nowe wydatki'),
      ),
      body: Column(
        children: [
          AddExpenseForm(
            expensesBloc: widget.expensesBloc,
          ),
          // Opcjonalnie: Wyświetlanie listy dodanych wydatków
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  leading: Icon(getCategoryIcon(expense.category)),
                  title: Text(expense.name),
                  subtitle: Text(
                      '${expense.amount.toStringAsFixed(2)} ${expense.currency.symbol}'),
                  trailing: Text(
                    '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Klasa reprezentująca wydatek
class Expense {
  final String name;
  final double amount;
  final ExpenseCategory category;
  final Currency currency;
  final DateTime date;

  Expense({
    required this.name,
    required this.amount,
    required this.category,
    required this.currency,
    required this.date,
  });
}

// Widget AddExpenseForm
class AddExpenseForm extends StatefulWidget {
  final ExpensesBloc expensesBloc;
  const AddExpenseForm({super.key, required this.expensesBloc});

  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  // Kontrolery do zarządzania wprowadzanymi danymi
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expenseDescriptionController =
      TextEditingController();
  final TextEditingController _placeOfPurchase = TextEditingController();

  // Zmienna do przechowywania wybranej kategorii
  ExpenseCategory? _selectedCategory;

  // Zmienna do przechowywania wybranej waluty
  Currency _selectedCurrency = Currency(
      code: 'USD',
      name: "United States Dollar",
      symbol: '\$',
      number: 840,
      flag: "USD",
      decimalDigits: 2,
      namePlural: 'US dollars',
      symbolOnLeft: true,
      decimalSeparator: '.',
      thousandsSeparator: ',',
      spaceBetweenAmountAndSymbol: false);

  // Klucz formularza do walidacji
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _expenseNameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _addExpense() async {
    // 1. Zbuduj obiekt Expanses
    Expanses expanse = Expanses(
      authorId: '6459f367dff5d419539cbd41',
      name: _expenseNameController.text.trim(),
      description: _expenseDescriptionController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      currency: _selectedCurrency.code,
      category: _selectedCategory.toString(),
      placeOfPurchase: _placeOfPurchase.text.trim(),
    );

    // 2. Stwórz Completer<bool>
    final completer = Completer<bool>();

    // 3. Dodaj event do Bloc, przekazując expanse i completer

    widget.expensesBloc.add(AddExpanseEvent(expanse, completer));

    // 4. Oczekuj na rezultat z bloca
    final success = await completer.future;

    // 5. Wyświetl SnackBar w zależności od powodzenia
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Wydatek "${_expenseNameController.text}" dodany w walucie ${_selectedCurrency.symbol}!',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wydatek nie został dodany!'),
        ),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _addExpense();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Dodano, aby uniknąć problemów z keyboardem
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Formularz nie rozciąga się na całą wysokość
            children: [
              // Pole tekstowe na nazwę wydatku
              TextFormField(
                controller: _expenseNameController,
                decoration: const InputDecoration(
                  labelText: 'Nazwa wydatku',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Proszę wpisać nazwę wydatku';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _expenseDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Opis wydatku',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              // Pole kwoty wydatku i wybór waluty obok siebie
              Row(
                children: [
                  // Pole tekstowe na kwotę wydatku
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Kwota',
                        border: const OutlineInputBorder(),
                        prefixText: _selectedCurrency != null
                            ? '${_selectedCurrency!.symbol} '
                            : '',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Proszę wpisać kwotę';
                        }
                        final parsed = double.tryParse(value.trim());
                        if (parsed == null || parsed <= 0) {
                          return 'Proszę wpisać prawidłową kwotę';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Przycisk do wyboru waluty
                  ElevatedButton(
                    onPressed: () {
                      showCurrencyPicker(
                        context: context,
                        showFlag: true, // Pokazuje flagi krajów obok nazw walut
                        showSearchField:
                            true, // Pokazuje pole wyszukiwania walut
                        onSelect: (Currency currency) {
                          print(currency.toJson());
                          setState(() {
                            _selectedCurrency = currency;
                          });
                        },
                      );
                    },
                    child: Text(
                      _selectedCurrency != null
                          ? _selectedCurrency!.symbol
                          : 'Wybierz walutę',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _expenseNameController,
                decoration: const InputDecoration(
                  labelText: 'Miejsce zakupu',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              // Dropdown do wyboru kategorii
              DropdownButtonFormField<ExpenseCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategoria',
                  border: OutlineInputBorder(),
                ),
                items: ExpenseCategory.values.map((ExpenseCategory category) {
                  return DropdownMenuItem<ExpenseCategory>(
                    value: category,
                    child: Text(getCategoryName(category)),
                  );
                }).toList(),
                onChanged: (ExpenseCategory? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Proszę wybrać kategorię';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              // Przycisk dodawania wydatku
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('DODAJ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
