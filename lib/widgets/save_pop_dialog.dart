import 'package:flutter/material.dart';

void savePopDialog(BuildContext context, String text, bool remove) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 1),
      backgroundColor: remove ? Colors.red : Colors.orange,
    ),
  );
}
