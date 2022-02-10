import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomElevatedButton extends HookWidget {
  late final void Function()? _onPressed;
  late final Widget _child;
  late final bool _selected;

  CustomElevatedButton({
    Key? key,
    required void Function()? onPressed,
    required Widget child,
    required bool selected,
  }) : super(key: key) {
    _onPressed = onPressed;
    _child = child;
    _selected = selected;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        onPressed: _onPressed,
        child: _child,
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: (_selected)? Colors.blue : Colors.transparent,
          side: const BorderSide(width: 5.0, color: Colors.transparent),
        ),
      ),
    );
  }
}
