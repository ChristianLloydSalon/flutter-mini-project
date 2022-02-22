import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/common/components/custom_appbar.dart';
import 'package:mini_project/common/components/custom_drawer.dart';
import 'package:mini_project/common/utils/screen_type.dart';
import 'package:mini_project/models/blog.dart';
import 'package:mini_project/modules/components/blog/blog_card.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_project/providers/blog/blog_provider.dart';
import 'package:mini_project/providers/route_constants_provider.dart';
import 'package:mini_project/providers/spacing_provider.dart';

import '../../../../common/components/carousel_slider.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState(false);

    final _routes = useProvider(routesProvider);
    final _blogs = useProvider(blogsProvider);
    final _spacing = useProvider(spacingProvider);

    loadData() async {
      _isLoading.value = true;
      await _blogs.initializeBlogs();
      _isLoading.value = false;
    }

    useEffect(() {
      loadData();
    }, []);

    return Scaffold(
      appBar: CustomAppBar(type: ScreenType.blog, constants: _routes),
      endDrawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(_routes.addBlogRouteName);
        },
        child: const Icon(Icons.edit),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCarousel(type: ScreenType.blog),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      if (_isLoading.value) ...[
                        Align(child: Padding(
                          padding: EdgeInsets.all(_spacing.medium),
                          child: const CircularProgressIndicator(strokeWidth: 3),
                        ), alignment: Alignment.center,),
                      ] else ...[
                        for (Blog blog in _blogs.blogPosts.reversed) ...[
                          BlogCard(blog: blog),
                        ],
                      ],
                    ],
                  ),
                ),
                const Expanded(child: Text('Recent Post')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
