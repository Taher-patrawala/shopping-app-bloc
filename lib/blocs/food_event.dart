import 'package:equatable/equatable.dart';
import 'package:food_delivery/model/food_model.dart';

abstract class FoodEvents {
  const FoodEvents();
}

class UpdateCart extends FoodEvents {
  final FoodModel item;
  final bool isAdd;

  const UpdateCart({required this.item, required this.isAdd});
}

class GetFoodList extends FoodEvents {}

class GetCart extends FoodEvents {}
