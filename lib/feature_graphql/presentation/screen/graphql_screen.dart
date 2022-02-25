import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/common/components/custom_appbar.dart';
import 'package:mini_project/common/components/custom_drawer.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/common/utils/screen_type.dart';
import 'package:mini_project/common/components/carousel_slider.dart';
import 'package:mini_project/feature_graphql/presentation/component/character_card.dart';
import 'package:mini_project/feature_graphql/presentation/component/loading_indicator.dart';
import 'package:mini_project/feature_graphql/presentation/viewmodel/rick_and_morty_viewmodel.dart';
import 'package:mini_project/common/provider/route_constants_provider.dart';
import 'package:mini_project/common/provider/spacing_provider.dart';

class GraphqlScreen extends HookWidget {
  const GraphqlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rickAndMortyViewModelProvider = useProvider(rickAndMortyViewModel);
    final _isLoading = useState(false);
    final _scrollController = useScrollController();
    final _routes = useProvider(routesProvider);
    final spacing = useProvider(spacingProvider);

    final height = MediaQuery.of(context).size.height;

    _loadData() async {
      _isLoading.value = true;
      await rickAndMortyViewModelProvider.getCharacters();
      _isLoading.value = false;
    }

    _getAdditionalInfo() async {
      await rickAndMortyViewModelProvider.getPages();
    }

    bool _isAllLoaded() {
      int maxPage = rickAndMortyViewModelProvider.info['count'] ?? 0;
      if (rickAndMortyViewModelProvider.characters.length == maxPage) {
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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(constants: _routes, type: ScreenType.graphql),
        endDrawer: const CustomDrawer(),
        body: Container(
          color: Colors.black,
          child: Builder(
            builder: (BuildContext context) {
              if (_isLoading.value && rickAndMortyViewModelProvider.characters.isEmpty) {
                return const LoadingIndicator();
              }

              if (!_isLoading.value && rickAndMortyViewModelProvider.characters.isEmpty) {
                return const Center(child: Text('No data'));
              }

              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.black,
                    expandedHeight: height * (Responsive.isMobile(context) ? 0.25 : Responsive.isTablet(context) ? 0.5 : 0.7),
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
                          rickAndMortyViewModelProvider.info['count']; //dummy

                          if (index == rickAndMortyViewModelProvider.characters.length &&
                              index + 1 < maxCharactersCount) {
                            return const LoadingIndicator();
                          } else if (index ==
                              rickAndMortyViewModelProvider.characters.length &&
                              index == maxCharactersCount) {
                            return const Center(
                              child: Text(
                                'No Data.',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return CharacterCard(
                            character: rickAndMortyViewModelProvider.characters[index],
                          );
                        },
                        childCount: rickAndMortyViewModelProvider.characters.length + 1,
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
      ),
    );
  }
}
