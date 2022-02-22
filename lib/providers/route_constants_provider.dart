import 'package:hooks_riverpod/hooks_riverpod.dart';

final routesProvider = Provider<RouteConstants>((ref) {
  return RouteConstants();
});

class RouteConstants {
  final String rootRouteName = 'root';
  final String homeRouteName = 'home';
  final String editBlogRouteName = 'edit';
  final String addBlogRouteName = 'add';
  final String viewBlogRouteName = 'view';
  final String graphqlRouteName = 'graphql';
}