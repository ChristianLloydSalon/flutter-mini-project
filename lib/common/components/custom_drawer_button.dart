import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/common/provider/spacing_provider.dart';

class CustomDrawerButton extends HookWidget {
  late final String _label;
  late final IconData _icon;
  late final Function() _onPressed;

  CustomDrawerButton({
    Key? key,
    required String label,
    required IconData icon,
    required Function() onPressed,
  }) : super(key: key) {
    _label = label;
    _onPressed = onPressed;
    _icon = icon;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = useProvider(spacingProvider);

    return Padding(
      padding: EdgeInsets.all(spacing.extraSmall),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: _onPressed,
          child: Stack(
            children: [
              Align(child: Icon(_icon), alignment: Alignment.centerLeft,),
              Center(child: Text(_label)),
            ],
          ),
        ),
      ),
    );
  }
}
