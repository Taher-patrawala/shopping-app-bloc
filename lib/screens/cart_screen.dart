import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_bloc.dart';
import 'package:food_delivery/blocs/food_state.dart';

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
              return Text(
                "Your cart has ${state.cartList.length.toString()} items.",
                style: TextStyle(fontSize: 18),
              );
            } else {
              return const Text("None");
            }
          },
        ),
      ),
    );
  }
}
