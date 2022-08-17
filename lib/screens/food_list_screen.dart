import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_bloc.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/widgets/food_item.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Shopping Center",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          _cartButton(context),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return BlocListener<FoodBloc, FoodState>(
      listener: (context, state) {
        if (state is FoodError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${state.message}"),
            ),
          );
        }
      },
      child: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodInitial) {
            return _buildLoading();
          } else if (state is FoodLoading) {
            return _buildLoading();
          } else if (state is FoodLoaded) {
            return _buildCard(state.foodList);
          } else if (state is FoodError) {
            return Center(
              child: Text(state.message.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildCard(List<FoodModel> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FoodItem(
          item: items[index],
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _cartButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        );
      },
      child: Container(
        height: 120,
        width: 100,
        // color: Colors.green,
        padding: const EdgeInsets.only(right: 8),
        margin: const EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              bottom: 0,
              right: 4,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 36,
              ),
            ),
            Positioned(
              bottom: 4,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: BlocBuilder<FoodBloc, FoodState>(
                  builder: (context, state) {
                    if (state is FoodLoaded) {
                      _calculateCartItems(state.cartList);
                      return Text(
                        "${_calculateCartItems(state.cartList)}",
                        style: const TextStyle(fontSize: 16),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _calculateCartItems(Map<int, int> cart) {
    return (cart.values
        .fold(0, (previousValue, element) => (previousValue as int) + element));
  }
}
