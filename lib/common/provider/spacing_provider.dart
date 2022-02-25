import 'package:hooks_riverpod/hooks_riverpod.dart';

final spacingProvider = Provider<Spacing>((ref) {
  return Spacing();
});

class Spacing {
  final extraSmall = 5.0;
  final small = 10.0;
  final medium = 20.0;
  final large = 40.0;
  final extraLarge = 100.0;
}