import 'package:equatable/equatable.dart';
import 'package:food_delivery/model/food_model.dart';

abstract class FoodEvents {
  const FoodEvents();
}

class AddItem extends FoodEvents {
  final FoodModel item;

  const AddItem(this.item);
}

class RemoveItem extends FoodEvents {
  final FoodModel item;

  const RemoveItem(this.item);
}

class GetFoodList extends FoodEvents {}

class GetCart extends FoodEvents {}
