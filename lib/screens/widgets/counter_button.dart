import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final Function addItem;
  final Function removeItem;
  final int count;

  const CounterButton({
    Key? key,
    required this.addItem,
    required this.removeItem,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => removeItem(),
          child: Container(
            child: const Icon(Icons.remove),
          ),
        ),
        Container(
          child: Text("$count"),
        ),
        InkWell(
          onTap: () => addItem(),
          child: Container(
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
