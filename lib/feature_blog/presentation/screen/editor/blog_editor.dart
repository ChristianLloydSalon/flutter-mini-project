import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/feature_blog/domain/model/blog.dart';
import 'package:mini_project/feature_blog/presentation/component/alert_dialogs/incomplete_data_dialog.dart';
import 'package:mini_project/feature_blog/presentation/component/custom_textfield.dart';
import 'package:mini_project/feature_blog/presentation/viewmodel/blogs_viewmodel.dart';
import 'package:mini_project/feature_blog/util/blog_checker.dart';
import 'package:mini_project/common/provider/route_constants_provider.dart';
import 'package:mini_project/common/provider/spacing_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class Editor extends HookWidget {
  late final Blog? _blog;

  Editor({Key? key, required Blog? blog}) : super(key: key) {
    _blog = blog;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = useProvider(spacingProvider);
    final routes = useProvider(routesProvider);
    final blogsViewModel = useProvider(blogsViewModelProvider);

    final bool isEditRoute = GoRouter.of(context).location == '/${routes.homeRouteName}/${routes.editBlogRouteName}';
    final bool isAddRoute = GoRouter.of(context).location == '/${routes.homeRouteName}/${routes.addBlogRouteName}';

    final _titleController = useTextEditingController();
    final _subtitleController = useTextEditingController();
    final _contentController = useTextEditingController();

    final _image = useState<Uint8List?>(null);

    if (_blog != null) {
      _titleController.text = _blog!.title;
      _subtitleController.text = _blog!.subtitle;
      _contentController.text = _blog!.content;
      _image.value = _blog!.image;
    }

    // get image in files
    Future _pickImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpeg', 'jpg']);

      if (result != null) {
        _image.value = result.files.first.bytes;
        if (_blog != null) _blog!.image = _image.value;
      }
    }

    // create blog
    _blogAddEdit() {
      Uuid uuid = const Uuid();
      final now = DateTime.now();
      String formatter = DateFormat.yMMMMd('en_US').format(now);

      final blog = Blog(
        id: (_blog != null) ? _blog!.id : uuid.v1(),
        title: _titleController.text,
        subtitle: _subtitleController.text,
        content: _contentController.text,
        date: formatter,
        image: _image.value,
      );

      bool status = isComplete(blog);
      if (status) {
        if (_blog == null) {
          blogsViewModel.addBlog(blog);
        } else {
          blogsViewModel.updateBlog(blog);
        }
        context.goNamed(routes.rootRouteName);
      }
      else {
        showIncompleteDataDialog(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((isEditRoute) ? 'Edit Blog' : 'Add New Blog'),
      ),
      body: (isAddRoute || (isEditRoute && _blog != null)) ?SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(spacing.small),
          child: Column(
            children: [
              CustomTextField(
                controller: _titleController,
                label: 'Title',
                style: (!Responsive.isMobile(context)) ? Theme.of(context).textTheme.headline1 : Theme.of(context).textTheme.subtitle1,
                maxLines: 1,
              ),
              SizedBox(height: spacing.small),
              CustomTextField(
                controller: _subtitleController,
                label: 'Subtitle',
                style: (!Responsive.isMobile(context)) ? Theme.of(context).textTheme.headline2 : Theme.of(context).textTheme.subtitle1,
                maxLines: 1,
              ),
              SizedBox(height: spacing.small),
              CustomTextField(
                controller: _contentController,
                label: 'Content',
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 5,
              ),
              SizedBox(height: spacing.small),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: AspectRatio(
                      aspectRatio: 2.3,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        child: (_image.value != null)
                            ? FittedBox(
                                fit: BoxFit.cover,
                                child: Image.memory(_image.value!),
                              )
                            : IconButton(
                                onPressed: _pickImage,
                                icon: FaIcon(
                                  FontAwesomeIcons.image,
                                  size:
                                      MediaQuery.of(context).size.height * .08,
                                  color: Colors.red,
                                ),
                              ),
                      ),
                    ),
                  ),
                  if (_image.value != null) ...[
                    SizedBox(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.windowClose,
                            size: MediaQuery.of(context).size.height * .03,
                          ),
                          color: Colors.black,
                          onPressed: () {
                            _image.value = null;
                            if (_blog != null) _blog!.image = null;
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: spacing.small),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: (Responsive.isDesktop(context)) ? 150 : 70,
                  child: ElevatedButton(
                    onPressed: _blogAddEdit,
                    child: (_blog != null)
                        ? const Text('Update')
                        : const Text('Post'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ) : const Center(child: Text('No Data to edit.')),
    );
  }
}
