import 'package:flutter/material.dart';

void snackbar(BuildContext context, String mess) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mess)));
}
