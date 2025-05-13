import 'package:flutter/material.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.price, this.onTap});

  final Price price;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      title: Text(
        price.name == null || price.name == "" ? "Без названия" : price.name!,
        style: theme.textTheme.titleLarge,
      ),
      subtitle: Text(
        "Базовая цена: ${price.defaultPrice} ₽${(price.conditions.isNotEmpty) ? "  ·  ${price.conditions.length}" : ""}",
      ),
    );
  }
}
