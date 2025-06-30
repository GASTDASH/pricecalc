import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class PriceGroup extends StatefulWidget {
  const PriceGroup({super.key, required this.group, required this.prices});

  final Group group;
  final List<Price> prices;

  @override
  State<PriceGroup> createState() => _PriceGroupState();
}

class _PriceGroupState extends State<PriceGroup> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => expanded = !expanded);
                },
                child: Container(
                  decoration: BoxDecoration(),
                  child: Row(
                    spacing: 12,
                    children: [
                      Text(
                        widget.group.uuid == "0"
                            ? "Без группы"
                            : (widget.group.name == null ||
                                widget.group.name! == "")
                            ? "Без названия"
                            : widget.group.name!,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AnimatedRotation(
                        duration: Duration(milliseconds: 500),
                        turns: expanded ? 0 : 0.25,
                        curve: Curves.easeOutExpo,
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
              ),
              ExpandedSection(
                expand: expanded,
                child: Column(
                  spacing: 24,
                  children: [
                    for (var price in widget.prices.where(
                      (price) => (price.groupUuid ?? "0") == widget.group.uuid,
                    ))
                      PriceRow(price: price),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
