import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_bloc.dart';
import 'package:food_delivery/blocs/food_event.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/screens/widgets/counter_button.dart';

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
              return _showCartItems(context, state.cartList, state.foodList);
            } else {
              return const Text("None");
            }
          },
        ),
      ),
    );
  }

  _showCartItems(
      BuildContext context, Map<int, int> cart, List<FoodModel> items) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
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
            return _cardItem(context, item, cart);
          } else {
            return Container();
          }
        },
        itemCount: cart.length,
      ),
    );
  }

  _cardItem(BuildContext context, FoodModel? item, Map<int, int> cart) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item != null ? item.name : ""}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${item != null ? item.ingredients : ""}",
                ),
              ],
            ),
            CounterButton(
              addItem: () {
                context.read<FoodBloc>().add(AddItem(item!));
              },
              removeItem: () {
                context.read<FoodBloc>().add(RemoveItem(item!));
              },
              count: cart[key]!,
            )
          ],
        ),
      ),
    );
  }
}
