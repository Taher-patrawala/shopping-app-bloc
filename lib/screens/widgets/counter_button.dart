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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: 120,
      decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => removeItem(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 12),
          Text(
            "$count",
            style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => addItem(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
