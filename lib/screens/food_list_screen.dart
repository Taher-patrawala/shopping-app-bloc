import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_bloc.dart';
import 'package:food_delivery/blocs/food_event.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/food_item.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({Key? key}) : super(key: key);

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  // final FoodBloc _newsBloc = FoodBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _newsBloc.add(GetFoodList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Domino's Pizza",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return BlocListener<FoodBloc, FoodState>(
      listener: (context, state) {
        if (state is FoodError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error"),
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
            return Container();
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
}
