import 'dart:convert';

import 'package:h_flutter_example_project/models/NumberItem.dart';
import 'package:hive/hive.dart';


class NumberService {
  Box<NumberItem>? _numberBox;

  Future<List<NumberItem>?> initializeHive() async {
    _numberBox = await Hive.openBox<NumberItem>("numberBox");
    List<NumberItem>? numbers = _numberBox?.values.toList();
    return numbers;
  }

  Future<void> deleteCoffeeItem(int index) async {
    await _numberBox?.deleteAt(index);
  }

  Future<void> addCoffeeItem(NumberItem coffeeItem) async{
    await _numberBox?.add(coffeeItem);
  }

}
