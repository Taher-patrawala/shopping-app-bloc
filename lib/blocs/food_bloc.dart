import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_event.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/repository/food_repo.dart';

class FoodBloc extends Bloc<FoodEvents, FoodState> {
  final FoodRepo repo = FoodRepo();

  FoodBloc() : super(FoodLoading()) {
    on<GetFoodList>(_getFoodList);
    on<UpdateCart>(_updateCart);
    on<UserRatedItem>(_updateRating);
  }

  void _getFoodList(GetFoodList event, Emitter<FoodState> emit) async {
    try {
      final foodDataList = await repo.getFoodList();
      emit(FoodLoaded(
          foodList: foodDataList!, cartList: {}, cartItemRatings: {}));
    } catch (e) {
      // print(e);
      emit(FoodError("Error occurred while fetching data!"));
    }
  }

  void _updateCart(UpdateCart event, Emitter<FoodState> emit) {
    Map<int, int> cart = Map<int, int>.from((state as FoodLoaded).cartList);
    if (cart[event.item.id] == null) {
      cart.addAll({event.item.id!: 0});
    }
    cart[event.item.id!] = cart[event.item.id!]! + event.quantity;
    if (cart[event.item.id]! == 0) {
      cart.remove(event.item.id);
    }
    emit(
      FoodLoaded(
        foodList: (state as FoodLoaded).foodList,
        cartList: cart,
        cartItemRatings: (state as FoodLoaded).cartItemRatings,
      ),
    );
  }

  void _updateRating(UserRatedItem event, Emitter<FoodState> emit) {
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
  }
}
