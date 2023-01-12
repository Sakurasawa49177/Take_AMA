import 'package:flutter/material.dart';

class Alert {
  static show({required BuildContext context, required String msg}) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
