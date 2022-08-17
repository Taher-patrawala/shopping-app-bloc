import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:http/http.dart' as http;

class FoodRepo {
  Future<List<FoodModel>?> getFoodList() async {

      final http.Response response = await http
          .get(Uri.https("fakestoreapi.com", "products", {"limit": "10"}));
      return List<FoodModel>.from(jsonDecode(response.body).map((food) {
        return FoodModel.fromJson(food);
      })).toList();

  }
}
