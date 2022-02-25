import 'package:flutter/material.dart';

showIncompleteDataDialog(BuildContext context) {
  AlertDialog _alert = AlertDialog(
    title: const Text('Incomplete Blog Data'),
    content: const Text('Please make sure to provide all information!'),
    actions: [
      TextButton(
        child: const Text('OK'),
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