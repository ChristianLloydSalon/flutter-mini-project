import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../api/graphql_api.dart';
import '../../../providers/graphql/characters_provider.dart';
import '../../domain/model/character.dart';

final rickAndMortyViewModel = ChangeNotifierProvider((ref) {
  final characters = ref.watch(charactersProvider);
  return RickAndMortyViewModel(charactersAPI: characters);
});

class RickAndMortyViewModel extends ChangeNotifier {
  CharactersAPI charactersAPI;
  int _page = 1;

  RickAndMortyViewModel({
    required this.charactersAPI,
  }) {
    _page = charactersAPI.getCurrentPage();
  }

  int get page => _page;

  List<Character> _characters = [];

  List<Character> get characters => _characters;

  Map<String, dynamic> _infos = {};

  Map<String, dynamic> get info => _infos;

  Future<List<Character>> getCharacters() async {
    //change this parameter
    final data = await charactersAPI.getCharacters(); // List<Characters>

    // _characters = data; //original

    if (_characters.isNotEmpty && data.isNotEmpty) {
      _characters = [
        ..._characters,
        ...data,
      ];
    } else if (_characters.isEmpty && data.isNotEmpty) {
      _characters = data;
    }
    return _characters;
  }

  Future<Map<String, dynamic>> getPages() async {
    //change this parameter
    final information = await charactersAPI.getInfo(); // List<Characters>

    // _characters = data; //original

    return _infos = information;
  }
}