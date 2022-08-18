import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_event.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/repository/food_repo.dart';

class FoodBloc extends Bloc<FoodEvents, FoodState> {
  final FoodRepo repo = FoodRepo();

  // Map<int, int> cart = {};
  // List<FoodModel> foodData = [];

  FoodBloc() : super(FoodInitial()) {
    on<GetFoodList>((event, emit) async {
      try {
        emit(FoodLoading());
        final foodDataList = await repo.getFoodList();
        if (foodDataList != null) {
          // foodData = foodDataList;
          emit(FoodLoaded(
              foodList: foodDataList, cartList: {}, cartItemRatings: {}));
        }
        if (foodDataList == null) {
          emit(FoodError("No Data Found"));
        }
      } catch (e) {
        print(e);
        emit(FoodError("No Data Found"));
      }
    });

    on<UpdateCart>((event, emit) {
      Map<int, int> cart = Map<int, int>.from((state as FoodLoaded).cartList);
      if (event.isAdd) {
        if (cart[event.item.id] == null) {
          cart.addAll({event.item.id!: 0});
        }
        cart[event.item.id!] = cart[event.item.id!]! + 1;
        emit(
          FoodLoaded(
            foodList: (state as FoodLoaded).foodList,
            cartList: cart,
            cartItemRatings: (state as FoodLoaded).cartItemRatings,
          ),
        );
      } else {
        if (cart[event.item.id]! - 1 == 0) {
          cart.remove(event.item.id);
        } else {
          cart[event.item.id!] = cart[event.item.id!]! - 1;
        }
        cart.remove(event.item);
        emit(
          FoodLoaded(
            foodList: (state as FoodLoaded).foodList,
            cartList: cart,
            cartItemRatings: (state as FoodLoaded).cartItemRatings,
          ),
        );
      }
      // print(cart);
    });

    on<UserRatedItem>((event, emit) {
      Map<int, double> rating = Map<int, double>.from(
        (state as FoodLoaded).cartItemRatings,
      );
      if (rating[event.item.id] == null) {
        rating.addAll({event.item.id!: 0});
      }
      rating[event.item.id!] = event.rating;
      // print(rating);
      emit(
        FoodLoaded(
          foodList: (state as FoodLoaded).foodList,
          cartList: (state as FoodLoaded).cartList,
          cartItemRatings: rating,
        ),
      );
    });
  }
}
