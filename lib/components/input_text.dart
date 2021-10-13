import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final Icon? icon;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;

  const InputTextField({
    Key? key,
    required this.labelText,
    this.hintText,
    required this.controller,
    this.icon,
    this.textStyle,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      style: textStyle ?? const TextStyle(fontSize: 16.0),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        icon: icon,
      ),
    );
  }
}
