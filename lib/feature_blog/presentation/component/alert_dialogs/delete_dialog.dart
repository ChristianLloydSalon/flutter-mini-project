import 'package:flutter/material.dart';

showDeleteAlertDialog(BuildContext context, Function() func) {
  AlertDialog _alert = AlertDialog(
    title: const Text('Delete Blog'),
    content: const Text('Are you sure you want to delete this?'),
    actions: [
      TextButton(
        child: const Text('OK'),
        onPressed: func,
      ),
      TextButton(
        child: const Text('CANCEL'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _alert;
    },
  );
}
