import 'package:equatable/equatable.dart';
import 'package:food_delivery/model/food_model.dart';

class FoodState {}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<FoodModel> foodList;
  final Map<int,int> cartList;

  FoodLoaded({required this.foodList, required this.cartList});
}

class FoodError extends FoodState {
  final String? message;

  FoodError(this.message);
}
