import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextField extends HookWidget {
  final TextEditingController controller;
  final String label;
  late final int minLines = 1;
  final int maxLines;
  final TextStyle? style;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.maxLines,
    required this.style,
    int minLines = 1,
  }) : super(key: key) {
    minLines = minLines;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration:
          InputDecoration(border: const OutlineInputBorder(), labelText: label),
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      minLines: maxLines,
      style: style,
    );
  }
}
