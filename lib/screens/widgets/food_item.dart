import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery/blocs/food_bloc.dart';
import 'package:food_delivery/blocs/food_event.dart';
import 'package:food_delivery/blocs/food_state.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/screens/widgets/counter_button.dart';

class FoodItem extends StatelessWidget {
  final FoodModel item;
  final bool showRating;

  const FoodItem({
    Key? key,
    required this.item,
    this.showRating = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.black, width: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.name.toString(),
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      item.ingredients.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade700),
                    ),
                  ),
                  const SizedBox(height: 12),
                  showRating
                      ? RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 26,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xffF2E900),
                          ),
                          onRatingUpdate: (rating) {
                            context.read<FoodBloc>().add(
                                  UserRatedItem(item: item, rating: rating),
                                );
                          },
                        )
                      // ? SizedBox(
                      //     width: 200,
                      //     child: Row(
                      //       children: List.generate(5, (index) {
                      //         return Row(
                      //           children: [
                      //             Icon(
                      //               index == 4 ? Icons.star_border : Icons.star,
                      //               color: index == 4
                      //                   ? Colors.black45
                      //                   : const Color(0xffF2E900),
                      //               size: 26,
                      //             ),
                      //             const SizedBox(width: 6),
                      //           ],
                      //         );
                      //       }),
                      //     ),
                      //   )
                      : BlocBuilder<FoodBloc, FoodState>(
                          builder: (context, state) {
                            if (state is FoodLoaded) {
                              return state.cartItemRatings[item.id] != null
                                  ? Row(
                                      children: [
                                        const Text(
                                          "Ratings: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${state.cartItemRatings[item.id]}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text("/5.0"),
                                      ],
                                    )
                                  : const Text(
                                      "Not rated",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    );
                            }
                            return Container();
                          },
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // color: Colors.red,
                  width: 130.0,
                  height: 110.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      item.imageLink.toString(),
                      fit: BoxFit.contain,
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
                          if (!contained) {
                            context
                                .read<FoodBloc>()
                                .add(UpdateCart(item: item, isAdd: true));
                          }
                        },
                        child: Container(
                          width: 130,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
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
                                      color: Colors.red, fontSize: 16),
                                )
                              : CounterButton(
                                  addItem: () {
                                    context.read<FoodBloc>().add(
                                        UpdateCart(item: item, isAdd: true));
                                  },
                                  count: state.cartList[item.id]!,
                                  removeItem: () {
                                    context.read<FoodBloc>().add(
                                        UpdateCart(item: item, isAdd: false));
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
