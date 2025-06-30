import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/condition/condition.dart';
import 'package:provider/provider.dart';

class EditConditionsBottomSheet extends StatefulWidget {
  const EditConditionsBottomSheet({
    super.key,
    required this.conditions,
    required this.units,
  });

  final List<Condition> conditions;
  final String units;

  @override
  State<EditConditionsBottomSheet> createState() =>
      _EditConditionsBottomSheetState();
}

class _EditConditionsBottomSheetState extends State<EditConditionsBottomSheet> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => ConditionRepository(widget.conditions),
      builder:
          (context, child) =>
          // TODO: Возможно лучше вынести в отдельный Custom виджет, но у меня пока не получилось
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent == 1) {
                setState(() => expanded = true);
              } else if (expanded) {
                setState(() => expanded = false);
              }
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.75,
              minChildSize: 0.3,
              maxChildSize: 1,
              builder: (context, controller) {
                return BottomSheetCustom(
                  padding: EdgeInsets.zero,
                  borderRadius: expanded ? BorderRadius.zero : null,
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: controller,
                          child: Column(
                            spacing: 12,
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
                                        ConditionRow(
                                          condition: condition,
                                          units: widget.units,
                                        ),
                                    ],
                                  );
                                },
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    context
                                        .read<ConditionRepository>()
                                        .addCondition();
                                  },
                                  child: Row(
                                    spacing: 6,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Добавить условие"),
                                      Icon(Icons.add),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
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
                    ],
                  ),
                );
              },
            ),
          ),
    );
  }
}
