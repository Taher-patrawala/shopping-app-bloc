import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_bloc.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/screens/widgets/food_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Center(
        child: BlocBuilder<FoodBloc, FoodState>(
          // bloc: FoodBloc(),
          builder: (context, state) {
            if (state is FoodLoaded) {
              if (state.cartList.isNotEmpty) {
                return _showCartItems(context, state.cartList, state.foodList);
              } else {
                return const Text(
                  "No Items In Your Cart",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  _showCartItems(
      BuildContext context, Map<int, int> cart, List<FoodModel> items) {
    return ListView.builder(
      itemBuilder: (context, index) {
        int key = cart.keys.elementAt(index);
        FoodModel? item;
        for (var element in items) {
          if (element.id == key) {
            item = element;
            break;
          }
        }
        if (cart[key] != 0) {
          return FoodItem(
            item: item!,
            showRating: false,
          );
          // _cardItem(context, item, cart[key]!);
        } else {
          return Container();
        }
      },
      itemCount: cart.length,
    );
  }
}
