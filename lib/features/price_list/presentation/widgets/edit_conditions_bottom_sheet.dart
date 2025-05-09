import 'package:flutter/material.dart';
import 'package:pricecalc/core/presentation/widgets/bottom_sheet_custom.dart';
import 'package:pricecalc/features/price_list/presentation/widgets/condition_row.dart';

class EditConditionsBottomSheet extends StatefulWidget {
  const EditConditionsBottomSheet({super.key});

  @override
  State<EditConditionsBottomSheet> createState() =>
      _EditConditionsBottomSheetState();
}

class _EditConditionsBottomSheetState extends State<EditConditionsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomSheetCustom(
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text("Условия расценки", style: theme.textTheme.titleLarge),
          ),
          ConditionRow(),
          ConditionRow(),
          ConditionRow(),
          ConditionRow(),
          TextButton(
            onPressed: () {},
            child: Row(
              spacing: 6,
              mainAxisSize: MainAxisSize.min,
              children: [Text("Добавить условие"), Icon(Icons.add)],
            ),
          ),
        ],
      ),
    );
  }
}
