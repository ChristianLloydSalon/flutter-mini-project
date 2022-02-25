import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/feature_blog/domain/model/blog.dart';
import 'package:mini_project/feature_blog/presentation/viewmodel/blogs_viewmodel.dart';
import 'package:mini_project/common/provider/route_constants_provider.dart';
import 'package:mini_project/common/provider/spacing_provider.dart';

import '../../component/alert_dialogs/delete_dialog.dart';

class ExpandedView extends HookWidget {
  late final Blog? _blog;

  ExpandedView({Key? key, Blog? blog}) : super(key: key) {
    _blog = blog;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = useProvider(spacingProvider);
    final blogsViewModel = useProvider(blogsViewModelProvider);
    final _routes = useProvider(routesProvider);

    final _loadScreen = useState((_blog == null) ? false : true);

    _deleteProcess() {
      if (_blog != null) {
        blogsViewModel.deleteBlog(_blog!);
      }
      Navigator.pop(context);
      context.goNamed(_routes.rootRouteName);
    }

    final ValueNotifier<Uint8List?> _image = useState<Uint8List?>(_blog?.image);

    return (_loadScreen.value) ? Scaffold(
      appBar: AppBar(
        title: Text(_blog!.title),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: PopupMenuButton(
              tooltip: 'Options',
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: const Text('Edit'),
                      onPressed: () {
                        Navigator.pop(context);
                        context.goNamed(_routes.editBlogRouteName,
                            extra: _blog);
                      },
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: const Text('Delete'),
                      onPressed: () {
                        Navigator.pop(context);
                        showDeleteAlertDialog(context, _deleteProcess);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: (_blog != null)
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(spacing.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Name',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: spacing.small),
                    Text(
                      'Date: ${_blog!.date}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: spacing.small),
                    const Divider(thickness: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _blog!.title,
                              style: (Responsive.isDesktop(context))
                                  ? Theme.of(context).textTheme.headline1
                                  : Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(height: spacing.extraSmall),
                            Text(
                              _blog!.subtitle,
                              style: (Responsive.isDesktop(context))
                                  ? Theme.of(context).textTheme.headline2
                                  : Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spacing.small),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: AspectRatio(
                        aspectRatio: 2.3,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.memory(_image.value!),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spacing.small),
                    Text(_blog!.content),
                  ],
                ),
              ),
            )
          : const Center(
              child: Text('Error: No Blog'),
            ),
    ) : const Scaffold(body: Center(child: Text('No data'),));
  }
}