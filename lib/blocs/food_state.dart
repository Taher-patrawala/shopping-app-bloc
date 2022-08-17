import 'package:equatable/equatable.dart';
import 'package:food_delivery/model/food_model.dart';

abstract class FoodState extends Equatable {}

class FoodInitial extends FoodState {
  @override
  List<Object?> get props => [];
}

class FoodLoading extends FoodState {
  @override
  List<Object?> get props => [];
}

class FoodLoaded extends FoodState {
  final List<FoodModel> foodList;
  final Map<int, int> cartList;
  final Map<int, double> cartItemRatings;

  FoodLoaded({
    required this.cartItemRatings,
    required this.foodList,
    required this.cartList,
  });

  @override
  List<Object?> get props => [foodList, cartList,cartItemRatings];
}

class FoodError extends FoodState {
  final String? message;

  FoodError(this.message);

  @override
  List<Object?> get props => [message];
}
