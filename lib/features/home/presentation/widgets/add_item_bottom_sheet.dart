import 'package:flutter/material.dart';
import 'package:pricecalc/core/presentation/widgets/bottom_sheet_custom.dart';
import 'package:pricecalc/features/home/presentation/widgets/item_chip.dart';

class AddItemBottomSheet extends StatefulWidget {
  const AddItemBottomSheet({super.key});

  @override
  State<AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomSheetCustom(
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16,
            children: [
              Flexible(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.hintColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(Icons.search),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Найти...",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Ink(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: theme.hintColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.list),
                ),
              ),
            ],
          ),
          Wrap(
            runSpacing: 12,
            spacing: 12,
            children: [
              ItemChip(),
              ItemChip(),
              ItemChip(),
              ItemChip(),
              ItemChip(),
            ],
          ),
        ],
      ),
    );
  }
}
