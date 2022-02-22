import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/config/route.dart';
import 'package:mini_project/themes/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: r"Gamer's Hub",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      routerDelegate: Routes.router.routerDelegate,
      routeInformationParser: Routes.router.routeInformationParser,
    );
  }
}
