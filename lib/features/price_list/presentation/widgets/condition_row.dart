import 'package:flutter/material.dart';

class ConditionRow extends StatelessWidget {
  const ConditionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          flex: 5,
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(hintText: "От"),
          ),
        ),
        Text("шт."),
        Icon(Icons.arrow_right_alt),
        Expanded(
          flex: 5,
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(hintText: "До"),
          ),
        ),
        Text("шт."),
        Icon(Icons.drag_handle),
        Expanded(
          flex: 5,
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
        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
      ],
    );
  }
}
