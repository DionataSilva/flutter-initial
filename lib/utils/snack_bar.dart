import 'package:bytebank/enums/snack_bar_type.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,
    {required String message, SnackBarType? type = SnackBarType.success}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor:
          type == SnackBarType.error ? Theme.of(context).errorColor : null,
    ),
  );
}