import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/api/graphql_api.dart';

final charactersProvider = Provider<CharactersAPI>((ref) {
  return CharactersAPI();
});