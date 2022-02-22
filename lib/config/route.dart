import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/models/blog.dart';
import 'package:mini_project/modules/screens/blog/blog_editor/blog_editor.dart';
import 'package:mini_project/modules/screens/blog/expanded_view/expanded_view.dart';
import 'package:mini_project/modules/screens/blog/home_screen/home_screen.dart';
import 'package:mini_project/modules/screens/graphql/graphql_screen/graphql_screen.dart';
import 'package:mini_project/providers/route_constants_provider.dart';

class Routes {
  static final _routes = useProvider(routesProvider);

  static final router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: _routes.rootRouteName,
        path: '/',
        redirect: (state) => state.namedLocation(_routes.homeRouteName),
      ),

      GoRoute(
        name: _routes.homeRouteName,
        path: '/home',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
        routes: [
          GoRoute(
            name: _routes.editBlogRouteName,
            path: 'edit',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: Editor(blog: state.extra as Blog?),
            ),
          ),
          GoRoute(
            name: _routes.addBlogRouteName,
            path: 'add',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: Editor(blog: state.extra as Blog?),
            ),
          ),
          GoRoute(
            name: _routes.viewBlogRouteName,
            path: 'view',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: ExpandedView(blog: state.extra as Blog?),
            ),
          ),
        ],
      ),

      GoRoute(
        name: _routes.graphqlRouteName,
        path: '/graphql',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const GraphqlScreen(),
        ),
      ),
    ],

    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );
}
