import 'package:cas_house/models/expanses.dart';
import 'package:cas_house/services/expanses_services.dart';
import 'package:flutter/material.dart';

class ExpansesProvider extends ChangeNotifier {
  List<Expanses> _expansesList = [];

  List<Expanses> get expansesList => _expansesList;

  Future<void> fetchExpenses() async {
    try {
      final List<Expanses>? result =
          await ExpansesServices().getExpansesByAuthor();
      if (result != null) {
        _expansesList = result;
      }
    } catch (e) {
      print("Error fetching expenses: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> addExpense(Expanses newExpense) async {
    try {
      final result = await ExpansesServices().addExpanse(newExpense);
      if (result != null) {
        _expansesList.insert(0, result);
        notifyListeners();
      }
    } catch (e) {
      print("Error adding expense: $e");
    }
  }

  Future<void> removeExpense(String expanseId) async {
    print(1);
    try {
      final result = await ExpansesServices().removeExpanse(expanseId);
      if (result == true) {
        var index =
            expansesList.indexWhere((expanse) => expanseId == expanse.id);
        print(index);
        _expansesList.removeAt(index);
        notifyListeners();
      }
    } catch (e) {
      print("Error removed expense: $e");
    }
  }
}
