import 'package:flutter/material.dart';


class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Icon? icon;

  const InputTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          icon: icon,
        ),
      ),
    );
  }
}
