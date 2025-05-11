import 'package:flutter/material.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class ItemChip extends StatelessWidget {
  const ItemChip({super.key, required this.price});

  final Price price;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Ink(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            price.name ?? "Без названия",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
