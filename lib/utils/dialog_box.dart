// ignore_for_file: must_be_immutable

import 'package:app/utils/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Add a New Task",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                ),
                SizedBox(width: 8),
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
