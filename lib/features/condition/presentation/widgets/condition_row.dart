import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/condition/condition.dart';
import 'package:provider/provider.dart';

class ConditionRow extends StatefulWidget {
  const ConditionRow({super.key, required this.condition, required this.units});

  final Condition condition;
  final String units;

  @override
  State<ConditionRow> createState() => _ConditionRowState();
}

class _ConditionRowState extends State<ConditionRow> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final priceController = TextEditingController();

  late Condition condition;

  @override
  void initState() {
    super.initState();

    condition = widget.condition;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          flex: 5,
          child: TextFieldCustom(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(hintText: "От"),
            controller:
                fromController..text = widget.condition.from?.toString() ?? "",
            onTapOutside: () {
              try {
                condition = condition.copyWith(
                  from: double.parse(fromController.text),
                );
                context.read<ConditionRepository>().updateCondition(condition);
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          ),
        ),
        Text(widget.units),
        Icon(Icons.arrow_right_alt),
        Expanded(
          flex: 5,
          child: TextFieldCustom(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(hintText: "До"),
            controller:
                toController..text = widget.condition.to?.toString() ?? "",
            onTapOutside: () {
              try {
                condition = condition.copyWith(
                  to: double.parse(toController.text),
                );
                context.read<ConditionRepository>().updateCondition(condition);
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          ),
        ),
        Text(widget.units),
        Icon(Icons.drag_handle),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Flexible(
                child: TextFieldCustom(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(hintText: "0"),
                  controller:
                      priceController
                        ..text = widget.condition.price?.toString() ?? "",
                  onTapOutside: () {
                    try {
                      condition = condition.copyWith(
                        price: double.parse(priceController.text),
                      );
                      context.read<ConditionRepository>().updateCondition(
                        condition,
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                ),
              ),
              Text("₽", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<ConditionRepository>().removeCondition(condition);
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
