import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/common/components/custom_appbar.dart';
import 'package:mini_project/common/components/custom_drawer.dart';
import 'package:mini_project/common/utils/screen_type.dart';
import 'package:mini_project/common/components/carousel_slider.dart';
import 'package:mini_project/modules/components/graphql/character_card.dart';
import 'package:mini_project/modules/components/graphql/loading_indicator.dart';
import 'package:mini_project/providers/graphql/graphql_provider.dart';
import 'package:mini_project/providers/route_constants_provider.dart';
import 'package:mini_project/providers/spacing_provider.dart';

class GraphqlScreen extends HookWidget {
  const GraphqlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState(false);
    final _charactersProvider = useProvider(initialCharactersProvider);
    final _scrollController = useScrollController();
    final _routes = useProvider(routesProvider);
    final spacing = useProvider(spacingProvider);

    _loadData() async {
      _isLoading.value = true;
      await _charactersProvider.getCharacters();
      _isLoading.value = false;
    }

    _getAdditionalInfo() async {
      await _charactersProvider.getPages();
    }

    bool _isAllLoaded() {
      int maxPage = _charactersProvider.info['count'] ?? 0;
      if (_charactersProvider.characters.length == maxPage) {
        return true;
      }
      return false;
    }

    useEffect(() {
      _loadData();
      _getAdditionalInfo();
    }, []);

    useEffect(() {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
          if (!_isAllLoaded()) {
            _loadData();
          }
        }
      });
    }, [_scrollController]);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(constants: _routes, type: ScreenType.graphql),
      endDrawer: const CustomDrawer(),
      body: Container(
        color: Colors.black,
        child: Builder(
          builder: (BuildContext context) {
            if (_isLoading.value && _charactersProvider.characters.isEmpty) {
              return const LoadingIndicator();
            }

            if (!_isLoading.value && _charactersProvider.characters.isEmpty) {
              return const Center(child: Text('No data'));
            }
            // 648.png
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.black,
                  expandedHeight: MediaQuery.of(context).size.height * .75,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CustomCarousel(type: ScreenType.graphql),
                  ),
                  actions: [Container()],
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                      top: spacing.small,
                      right: spacing.small,
                      left: spacing.small,
                  ),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final maxCharactersCount =
                        _charactersProvider.info['count']; //dummy

                        if (index == _charactersProvider.characters.length &&
                            index + 1 < maxCharactersCount) {
                          return const LoadingIndicator();
                        } else if (index ==
                            _charactersProvider.characters.length &&
                            index == maxCharactersCount) {
                          return const Center(
                            child: Text(
                              'Nothing to load.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return CharacterCard(
                          character: _charactersProvider.characters[index],
                        );
                      },
                      childCount: _charactersProvider.characters.length + 1,
                    ),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.5,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
