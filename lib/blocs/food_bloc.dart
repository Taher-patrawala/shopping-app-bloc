import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_event.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/repository/food_repo.dart';

class FoodBloc extends Bloc<FoodEvents, FoodState> {
  final FoodRepo repo = FoodRepo();

  Map<int, int> cart = {};
  List<FoodModel> foodData = [];

  FoodBloc() : super(FoodInitial()) {
    on<GetFoodList>((event, emit) async {
      try {
        emit(FoodLoading());
        final foodDataList = await repo.getFoodList();
        if (foodDataList != null) {
          foodData = foodDataList;
          emit(FoodLoaded(foodList: foodDataList, cartList: cart));
        }
        if (foodDataList == null) {
          emit(FoodError("message"));
        }
      } catch (e) {
        emit(FoodError(e.toString()));
      }
    });
    on<AddItem>((event, emit) {
      if (cart[event.item.id] == null) {
        cart.addAll({event.item.id!: 0});
      }
      cart[event.item.id!] = cart[event.item.id!]! + 1;
      FoodLoaded state = FoodLoaded(foodList: foodData, cartList: cart);
      emit(state);
      // print(cart);
    });
    on<RemoveItem>((event, emit) {
      if (cart[event.item.id]! - 1 == 0) {
        cart.remove(event.item.id);
      } else {
        cart[event.item.id!] = cart[event.item.id!]! - 1;
      }
      cart.remove(event.item);
      emit(FoodLoaded(foodList: foodData, cartList: cart));
      // print(cart);
    });
  }
}
