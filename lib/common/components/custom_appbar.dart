import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/common/utils/screen_type.dart';
import 'package:mini_project/providers/route_constants_provider.dart';

class CustomAppBar extends PreferredSize {
  late final ScreenType _type;
  late final RouteConstants _constants;

  CustomAppBar(
      {Key? key, required ScreenType type, required RouteConstants constants})
      : super(
          preferredSize: const Size(double.infinity, 50),
          child: Container(),
          key: key,
        ) {
    _type = type;
    _constants = constants;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(r"Gamer's Hub"),
      leading: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10),
        child: Image.asset('assets/images/logo.png', color: Colors.white),
      ),
      actions: (Responsive.isDesktop(context))
          ? <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // go to Blog
                    context.goNamed(_constants.rootRouteName);
                  },
                  child: const Text('Blog'),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: (_type == ScreenType.blog)
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // go to graphql
                    context.goNamed(_constants.graphqlRouteName);
                  },
                  child: const Text('GraphQL'),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: (_type == ScreenType.graphql)
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ]
          : <Widget>[
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ],
    );
  }
}
