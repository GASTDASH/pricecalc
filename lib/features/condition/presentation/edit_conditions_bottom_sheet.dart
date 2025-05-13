import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/condition/condition.dart';
import 'package:provider/provider.dart';

class EditConditionsBottomSheet extends StatelessWidget {
  const EditConditionsBottomSheet({
    super.key,
    required this.conditions,
    required this.units,
  });

  final List<Condition> conditions;
  final String units;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => ConditionRepository(conditions),
      builder:
          (context, child) => BottomSheetCustom(
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Условия расценки",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                Consumer<ConditionRepository>(
                  builder: (_, repo, _) {
                    return Column(
                      spacing: 16,
                      children: [
                        for (var condition in repo.value)
                          ConditionRow(condition: condition, units: units),
                      ],
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    context.read<ConditionRepository>().addCondition();
                  },
                  child: Row(
                    spacing: 6,
                    mainAxisSize: MainAxisSize.min,
                    children: [Text("Добавить условие"), Icon(Icons.add)],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ButtonCustom(
                        text: "Сохранить",
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pop(context.read<ConditionRepository>().value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
