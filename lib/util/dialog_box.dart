import 'package:flutter/material.dart';
import 'package:task_app/util/my_button.dart';

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
      backgroundColor: const Color.fromARGB(255, 192, 178, 195),
      content: Container(
        height: 130,
        child: Column(
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Add a new task"),
            ),
            SizedBox(
              height: 20,
            ),
            //buttons->save and cancel

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //save button

                MyButton(text: "Save", onPressed: onSave),

                //cancel button
                MyButton(text: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
