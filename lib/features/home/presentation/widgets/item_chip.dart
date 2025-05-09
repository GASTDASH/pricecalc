import 'package:flutter/material.dart';

class ItemChip extends StatelessWidget {
  const ItemChip({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Ink(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Text("Какой-то товар", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
