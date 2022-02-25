import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/common/components/carousel_slider.dart';
import 'package:mini_project/common/components/custom_appbar.dart';
import 'package:mini_project/common/components/custom_drawer.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/common/utils/screen_type.dart';
import 'package:mini_project/feature_blog/domain/model/blog.dart';
import 'package:mini_project/feature_blog/presentation/component/blog_card.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_project/feature_blog/presentation/viewmodel/blogs_viewmodel.dart';
import 'package:mini_project/common/provider/route_constants_provider.dart';
import 'package:mini_project/common/provider/spacing_provider.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState(false);

    final _routes = useProvider(routesProvider);
    final _spacing = useProvider(spacingProvider);

    final _blogsViewModel = useProvider(blogsViewModelProvider);

    Future<void> loadData() async {
      _isLoading.value = true;
      await _blogsViewModel.initializeBlogs();
      _isLoading.value = false;
    }

    useEffect(() {
      loadData();
      return;
    }, []);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(type: ScreenType.blog, constants: _routes),
        endDrawer: const CustomDrawer(),
        floatingActionButton: (Responsive.isMobile(context))
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                onPressed: () {
                  context.goNamed(_routes.addBlogRouteName);
                },
                child: const Icon(Icons.edit),
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCarousel(type: ScreenType.blog),
              Padding(
                padding: (!Responsive.isMobile(context))
                    ? EdgeInsets.only(
                        left: _spacing.extraLarge,
                        right: _spacing.extraLarge,
                        top: _spacing.medium)
                    : EdgeInsets.all(_spacing.medium),
                child: Column(
                  children: [
                    if (!Responsive.isMobile(context)) ...[
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed(_routes.addBlogRouteName);
                        },
                        child: const Text('Create Blog Post'),
                      ),
                    ],
                    if (_isLoading.value) ...[
                      Align(
                        child: Padding(
                          padding: EdgeInsets.all(_spacing.medium),
                          child:
                              const CircularProgressIndicator(strokeWidth: 3),
                        ),
                        alignment: Alignment.center,
                      ),
                    ] else ...[
                      for (Blog blog in _blogsViewModel.blogPosts.reversed) ...[
                        BlogCard(blog: blog),
                      ],
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
