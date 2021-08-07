import 'package:flutter/material.dart';

class ReminderForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> validator;
  const ReminderForm({Key key, this.hintText, this.controller, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        cursorWidth: 1,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 16),
            errorBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }
}
