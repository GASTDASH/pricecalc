import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';

class RenameDialog extends StatelessWidget {
  RenameDialog({super.key, this.oldName});

  final String? oldName;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldCustom(
                decoration: InputDecoration(hintText: "Название"),
                controller: nameController,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop(nameController.text);
                  },
                  child: Text("ОК"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
