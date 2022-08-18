import 'package:equatable/equatable.dart';
import 'package:food_delivery/model/food_model.dart';

abstract class FoodEvents {
  const FoodEvents();
}

class UpdateCart extends FoodEvents {
  final FoodModel item;
  final int quantity;

  const UpdateCart({required this.item, required this.quantity});
}

class GetFoodList extends FoodEvents {}

class GetCart extends FoodEvents {}

class UserRatedItem extends FoodEvents {
  final FoodModel item;
  final double rating;

  UserRatedItem({required this.item,required this.rating});
}
