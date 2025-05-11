import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/home/presentation/widgets/name_box.dart';

class ItemRow extends StatelessWidget {
  ItemRow({super.key, this.index});

  final countController = TextEditingController(text: "1");
  final int? index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      spacing: 6,
      children: [
        index != null
            ? ReorderableDragStartListener(index: index!, child: NameBox())
            : NameBox(),
        Icon(Icons.close),
        Flexible(
          child: TextFieldCustom(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: countController,
          ),
        ),
        Text("шт.", style: theme.textTheme.bodyLarge),
        Icon(Icons.drag_handle),
        Text("60 ₽", style: theme.textTheme.titleLarge?.copyWith()),
      ],
    );
  }
}
