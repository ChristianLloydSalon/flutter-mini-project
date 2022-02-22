import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/models/blog.dart';
import 'package:mini_project/modules/components/blog/custom_textfield.dart';
import 'package:mini_project/modules/screens/blog/utils/blog_checker.dart';
import 'package:mini_project/providers/blog/blog_provider.dart';
import 'package:mini_project/providers/route_constants_provider.dart';
import 'package:mini_project/providers/spacing_provider.dart';
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
    final blogs = useProvider(blogsProvider);

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
          print('add ${blog.id}');
          blogs.addBlog(blog);
        } else {
          print('edit ${blog.id}');
          blogs.updateBlog(blog);
        }
        context.goNamed(routes.rootRouteName);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(spacing.small),
          child: Column(
            children: [
              CustomTextField(
                controller: _titleController,
                label: 'Title',
                style: Theme.of(context).textTheme.headline1,
                maxLines: 1,
              ),
              SizedBox(height: spacing.small),
              CustomTextField(
                controller: _subtitleController,
                label: 'Subtitle',
                style: Theme.of(context).textTheme.headline2,
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
      ),
    );
  }
}
