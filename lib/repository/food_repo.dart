import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:food_delivery/model/food_model.dart';

class FoodRepo {
  Future<List<FoodModel>?> getFoodList() async {
    final String response =
        await rootBundle.loadString('lib/assets/data/data.json');
    return List<FoodModel>.from(jsonDecode(response).map((food) {
      return FoodModel.fromJson(food);
    })).toList();
  }
}
