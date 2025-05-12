import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    this.controller,
    this.decoration = const InputDecoration(),
    this.style,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.onTapOutside,
    this.onChanged,
  });

  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final void Function()? onTapOutside;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      groupId: UniqueKey(),
      style: style ?? TextStyle(fontSize: 16),
      decoration: decoration,
      controller: controller,
      textAlign: textAlign,
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        if (onTapOutside != null) onTapOutside!();
        debugPrint("=================");
      },
      keyboardType: keyboardType,
    );
  }
}
