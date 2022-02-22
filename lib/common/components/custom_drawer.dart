import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/common/components/custom_drawer_button.dart';
import 'package:mini_project/providers/route_constants_provider.dart';

class CustomDrawer extends HookWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _routes = useProvider(routesProvider);

    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              CustomDrawerButton(
                label: 'Blog',
                icon: FontAwesomeIcons.gamepad,
                onPressed: () {
                  context.goNamed(_routes.rootRouteName);
                },
              ),
              CustomDrawerButton(
                label: 'GraphQL',
                icon: FontAwesomeIcons.child,
                onPressed: () {
                  context.goNamed(_routes.graphqlRouteName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
