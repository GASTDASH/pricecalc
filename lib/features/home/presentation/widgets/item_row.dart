import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';

class ItemRow extends StatelessWidget {
  ItemRow({super.key, this.index});

  final countController = TextEditingController(text: "1");
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        index != null
            ? ReorderableDragStartListener(
              index: index!,
              child: _buildNameBox(),
            )
            : _buildNameBox(),
        Icon(Icons.close),
        Flexible(
          child: TextFieldCustom(
            textAlign: TextAlign.center,
            controller: countController,
          ),
        ),
        Text("шт.", style: TextStyle(fontSize: 16)),
        Icon(Icons.drag_handle),
        Text(
          "60 ₽",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Material _buildNameBox() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Ink(
          height: 60,
          width: 160,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            // boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: Center(
            child: Text(
              "Какой-то товар",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
