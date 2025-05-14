import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/home/home.dart';

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
  void initState() {
    super.initState();

    quantityController.text =
        (widget.calcItem.quantity % 1 == 0)
            ? widget.calcItem.quantity.truncate().toString()
            : widget.calcItem.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(widget.calcItem.uuid),
      direction: DismissDirection.endToStart,
      onDismissed: widget.onDismissed,
      background: Container(
        color: theme.hintColor.withValues(alpha: 0.1),
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
          widget.index != null
              ? ReorderableDragStartListener(
                index: widget.index!,
                child: NameBox(
                  name:
                      widget.calcItem.price.name == null ||
                              widget.calcItem.price.name == ""
                          ? "Без названия"
                          : widget.calcItem.price.name!,
                ),
              )
              : NameBox(name: widget.calcItem.price.name ?? "Без названия"),
          Icon(Icons.close),
          Flexible(
            child: TextFieldCustom(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: quantityController,
              onChanged: widget.onChanged,
            ),
          ),
          Text(
            widget.calcItem.price.units ?? "шт.",
            style: theme.textTheme.bodyLarge,
          ),
          Icon(Icons.drag_handle),
          Text(
            "${widget.calcItem.totalPrice()} ₽",
            style: theme.textTheme.titleLarge?.copyWith(),
          ),
        ],
      ),
    );
  }
}
