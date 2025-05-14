import 'package:flutter/material.dart';

class NameBox extends StatelessWidget {
  const NameBox({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        // onTap: () {},
        child: Ink(
          height: 60,
          width: 140,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            // boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: Center(
            child: Text(
              name,
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
