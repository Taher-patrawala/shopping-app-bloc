import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_bloc.dart';
import 'package:food_delivery/blocs/food_event.dart';
import 'package:food_delivery/screens/food_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return FoodBloc()..add(GetFoodList());
      },
      child: MaterialApp(
        title: 'Flutter Demo',

        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Inter",

        ),
        home: const FoodListScreen(),
      ),
    );
  }
}
