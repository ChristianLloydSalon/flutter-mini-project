import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mini_project/config/graphql.dart';
import 'package:mini_project/models/character.dart';

class CharactersAPI {
  int _page = 1;

  final String _getCharacters = r'''
  query GetCharacters($page: Int){
    characters(page: $page) {
      results {
        id
        name
        image
      }
    }
  }
  ''';

  final String _getInfo = r'''
  query GetCharacters{
    characters{
      info{
        count
        pages
        next
        prev
      }
    }
  }
  ''';

  // Get Characters Info API call
  Future<Map<String, dynamic>> getInfo() async {
    final options = QueryOptions(document: gql(_getInfo));

    final response = await graphQlClient.query(options);

    if (!response.hasException) {
      final data = response.data!['characters']['info'];
      return data;
    } else {
      return {};
    }
  }

  // Get Characters API call
  Future<List<Character>> getCharacters() async {
    //write the document

    final options = QueryOptions(document: gql(_getCharacters), variables: {
      'page': _page,
    });

    final response = await graphQlClient.query(options);

    if (!response.hasException) {
      final List<Object?> data = response.data!['characters']['results'];

      final values = data.map((character) => Character.fromJson(character as Map<String, dynamic>));

      _page++;

      return values.toList();
    } else {
      return [];
    }
  }

  // Get Current Page
  int getCurrentPage() {
    return _page;
  }
}