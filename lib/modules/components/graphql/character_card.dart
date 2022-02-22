import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/models/character.dart';

class CharacterCard extends HookWidget {
  final Character character;

  const CharacterCard({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.8,
            child: Image.network(
              character.image ?? '',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name ?? '',
              textAlign: TextAlign.center,
              style: (Responsive.isDesktop(context)) ? Theme.of(context).textTheme.subtitle1 : Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
