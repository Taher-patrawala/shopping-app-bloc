import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/blocs/food_bloc.dart';
import 'package:food_delivery/blocs/food_event.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/screens/widgets/counter_button.dart';

class FoodItem extends StatelessWidget {
  final FoodModel item;

  const FoodItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.black, width: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.name.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: Text(
                      item.ingredients.toString(),
                      maxLines: 2,
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 200,
                    child: Row(
                      children: List<Icon>.generate(5, (index) {
                        return Icon(
                          index == 4 ? Icons.star_border : Icons.star,
                          color: index == 4 ? Colors.black45 : Colors.yellow,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.red,
                  width: 130.0,
                  height: 110.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      item.imageLink.toString(),
                      fit: BoxFit.cover,
                      scale: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<FoodBloc, FoodState>(
                  buildWhen: (p, c) => true,
                  builder: (context, state) {
                    if (state is FoodLoaded) {
                      bool contained = false;
                      for (var element in state.cartList.keys) {
                        if (element == item.id) {
                          contained = true;
                        }
                      }
                      return InkWell(
                        onTap: () {
                          context.read<FoodBloc>().add(AddItem(item));
                        },
                        child: Container(
                          width: 130,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0.5),
                            border: Border.all(
                              color:
                                  contained ? Colors.transparent : Colors.red,
                            ),
                          ),
                          child: !contained
                              ? const Text(
                                  "ADD",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )
                              : CounterButton(
                                  addItem: () {
                                    context.read<FoodBloc>().add(AddItem(item));
                                  },
                                  count: state.cartList[item.id]!,
                                  removeItem: () {
                                    context
                                        .read<FoodBloc>()
                                        .add(RemoveItem(item));
                                  },
                                ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
