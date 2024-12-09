import 'package:cas_house/models/expanses.dart';
import 'package:cas_house/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';

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
  final ExpansesProvider provider;
  const AddNewExpensesPopup({super.key, required this.provider});

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
          AddExpenseForm(provider: widget.provider),
          // Opcjonalnie: Wyświetlanie listy dodanych wydatków
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  leading: Icon(_getCategoryIcon(expense.category)),
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

  // Funkcja pomocnicza do pobrania ikony na podstawie kategorii
  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Icons.fastfood;
      case ExpenseCategory.housing:
        return Icons.home;
      case ExpenseCategory.utilities:
        return Icons.lightbulb;
      case ExpenseCategory.transportation:
        return Icons.directions_car;
      case ExpenseCategory.healthcare:
        return Icons.healing;
      case ExpenseCategory.entertainment:
        return Icons.movie;
      case ExpenseCategory.education:
        return Icons.school;
      case ExpenseCategory.personalCare:
        return Icons.person;
      case ExpenseCategory.clothing:
        return Icons.shopping_bag;
      case ExpenseCategory.savings:
        return Icons.savings;
      case ExpenseCategory.debtRepayment:
        return Icons.money_off;
      case ExpenseCategory.insurance:
        return Icons.security;
      case ExpenseCategory.miscellaneous:
        return Icons.more_horiz;
      default:
        return Icons.help;
    }
  }

  // Funkcja pomocnicza do konwersji enum na czytelną nazwę
  String _getCategoryName(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return 'Jedzenie';
      case ExpenseCategory.housing:
        return 'Mieszkanie';
      case ExpenseCategory.utilities:
        return 'Media';
      case ExpenseCategory.transportation:
        return 'Transport';
      case ExpenseCategory.healthcare:
        return 'Opieka zdrowotna';
      case ExpenseCategory.entertainment:
        return 'Rozrywka';
      case ExpenseCategory.education:
        return 'Edukacja';
      case ExpenseCategory.personalCare:
        return 'Pielęgnacja osobista';
      case ExpenseCategory.clothing:
        return 'Odzież';
      case ExpenseCategory.savings:
        return 'Oszczędności';
      case ExpenseCategory.debtRepayment:
        return 'Spłata długów';
      case ExpenseCategory.insurance:
        return 'Ubezpieczenie';
      case ExpenseCategory.miscellaneous:
        return 'Inne';
      default:
        return '';
    }
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
  final ExpansesProvider provider;
  const AddExpenseForm({super.key, required this.provider});

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
    // Pamiętaj o zwolnieniu kontrolerów
    _expenseNameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addExpense() {
    Expanses expanse = Expanses(
        authorId: '6459f367dff5d419539cbd41',
        name: _expenseNameController.text.trim(),
        description: _expenseDescriptionController.text.trim(),
        amount: double.parse(_amountController.text.trim()),
        currency: _selectedCurrency.code,
        category: _selectedCategory.toString(),
        placeOfPurchase: _placeOfPurchase.text.trim());
    // Opcjonalnie: Pokazanie komunikatu potwierdzającego
    widget.provider.addExpanse(expanse);
    // if (success) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text('Wydatek "name" dodany w walucie currency.symbol!')),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Wydatek nie został dodany!')),
    //   );
    // }
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
                    child: Text(_getCategoryName(category)),
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

  // Funkcja pomocnicza do konwersji enum na czytelną nazwę
  String _getCategoryName(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return 'Jedzenie';
      case ExpenseCategory.housing:
        return 'Mieszkanie';
      case ExpenseCategory.utilities:
        return 'Media';
      case ExpenseCategory.transportation:
        return 'Transport';
      case ExpenseCategory.healthcare:
        return 'Opieka zdrowotna';
      case ExpenseCategory.entertainment:
        return 'Rozrywka';
      case ExpenseCategory.education:
        return 'Edukacja';
      case ExpenseCategory.personalCare:
        return 'Pielęgnacja osobista';
      case ExpenseCategory.clothing:
        return 'Odzież';
      case ExpenseCategory.savings:
        return 'Oszczędności';
      case ExpenseCategory.debtRepayment:
        return 'Spłata długów';
      case ExpenseCategory.insurance:
        return 'Ubezpieczenie';
      case ExpenseCategory.miscellaneous:
        return 'Inne';
      default:
        return '';
    }
  }
}
