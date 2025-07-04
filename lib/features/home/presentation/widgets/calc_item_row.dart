import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/utils/utils.dart';

class CalcItemRow extends StatefulWidget {
  const CalcItemRow({
    super.key,
    this.index,
    required this.calcItem,
    this.onDismissed,
    this.onChanged,
  });

  final int? index;
  final CalcItem calcItem;
  final void Function(DismissDirection)? onDismissed;
  final void Function(String)? onChanged;

  @override
  State<CalcItemRow> createState() => _CalcItemRowState();
}

class _CalcItemRowState extends State<CalcItemRow> {
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    quantityController.text = (widget.calcItem.quantity.truncateIfInt());
    final totalPrice = widget.calcItem.totalPrice();

    return Dismissible(
      key: ValueKey(widget.calcItem.uuid),
      direction: DismissDirection.endToStart,
      onDismissed: widget.onDismissed,
      background: Container(
        decoration: BoxDecoration(
          color: theme.hintColor.withValues(alpha: 0.1),
          boxShadow: [
            BoxShadow(color: Colors.black45),
            BoxShadow(color: Colors.white70, spreadRadius: -2, blurRadius: 10),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 12,
            children: [Text("Удалить"), Icon(Icons.delete_outline)],
          ),
        ),
      ),
      child: Row(
        spacing: 6,
        children: [
          // widget.index != null
          //     ? ReorderableDragStartListener(
          //       index: widget.index!,
          //       child: NameBox(
          //         name:
          //             widget.calcItem.price.name == null ||
          //                     widget.calcItem.price.name == ""
          //                 ? "Без названия"
          //                 : widget.calcItem.price.name!,
          //       ),
          //     )
          //     :
          NameBox(name: widget.calcItem.price.name ?? "Без названия"),
          Icon(Icons.close),
          Flexible(
            child: TextFieldCustom(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: quantityController,
              // Или
              onChanged: widget.onChanged,
              // Или
              onTapOutside: () {
                if (widget.onChanged != null) {
                  widget.onChanged!(quantityController.text);
                }
              },
            ),
          ),
          Text(
            widget.calcItem.price.units ?? "шт.",
            style: theme.textTheme.bodyLarge,
          ),
          Icon(Icons.drag_handle),
          Text(
            "${totalPrice.truncateIfInt()} ₽",
            style: theme.textTheme.titleLarge?.copyWith(),
          ),
        ],
      ),
    );
  }
}
