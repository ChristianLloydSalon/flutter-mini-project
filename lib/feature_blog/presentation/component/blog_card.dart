import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/feature_blog/domain/model/blog.dart';
import 'package:mini_project/feature_blog/presentation/viewmodel/blogs_viewmodel.dart';
import 'package:mini_project/common/provider/route_constants_provider.dart';
import 'package:mini_project/common/provider/spacing_provider.dart';
import 'package:go_router/go_router.dart';

import 'alert_dialogs/delete_dialog.dart';

class BlogCard extends HookWidget {
  late final Blog _blog;

  BlogCard({Key? key, required Blog blog}) : super(key: key) {
    _blog = blog;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = useProvider(spacingProvider);
    final _blogsViewModel = useProvider(blogsViewModelProvider);
    final _routes = useProvider(routesProvider);

    _deleteProcess() {
      _blogsViewModel.deleteBlog(_blog);
      Navigator.pop(context);
    }

    return Card(
      child: InkWell(
        onTap: () {
          context.goNamed(_routes.viewBlogRouteName, extra: _blog);
        },
        child: Padding(
          padding: EdgeInsets.all(spacing.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Christian Lloyd Salon',
                          style: Theme.of(context).textTheme.subtitle1),
                      Text('Date: ${_blog.date}',
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
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
                                context.goNamed(_routes.editBlogRouteName, extra: _blog);
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
              SizedBox(height: spacing.small),
              AspectRatio(
                  aspectRatio: 1.3,
                  child: Image.memory(
                    _blog.image!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
              SizedBox(height: spacing.small),
              Text(
                _blog.title,
                style: (Responsive.isDesktop(context))
                    ? Theme.of(context).textTheme.headline1
                    : Theme.of(context).textTheme.headline2,
              ),
              Text(
                _blog.subtitle,
                style: (Responsive.isDesktop(context))
                    ? Theme.of(context).textTheme.headline2
                    : Theme.of(context).textTheme.headline3,
              ),
              const Divider(thickness: 2),
              Text(
                _blog.content,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
