import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/price_list/presentation/widgets/edit_conditions_bottom_sheet.dart';

class ItemEditRow extends StatelessWidget {
  const ItemEditRow({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      spacing: 8,
      children: [
        Expanded(
          flex: 6,
          child: TextField(
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(hintText: "Название"),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(hintText: "(шт.)"),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(hintText: "0"),
                ),
              ),
              Text("₽", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed:
                  () => {
                    showModalBottomSheetCustom(
                      context: context,
                      builder: (context) => EditConditionsBottomSheet(),
                    ),
                  },
              icon: Badge(
                alignment: Alignment.bottomRight,
                backgroundColor: theme.primaryColor,
                label: Text("1"),
                child: Icon(Icons.edit),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          ],
        ),
      ],
    );
  }
}
