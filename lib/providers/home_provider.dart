import 'package:cas_house/api_service.dart';
import 'package:cas_house/models/expanses.dart';
import 'package:cas_house/services/expanses_services.dart';
import 'package:flutter/material.dart';

class ExpansesProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  addExpanse(Expanses expanse) async {
    final result = await ExpansesServices().addExpanse(expanse);
    // final result = await ApiService().fetchGreeting();
    print(result);
    // if (result['success']) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
