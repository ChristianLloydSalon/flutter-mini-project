import 'package:mini_project/models/blog.dart';

bool isComplete(Blog blog) {
  if (blog.title != '' &&
      blog.subtitle != '' &&
      blog.content != '' &&
      blog.date != '' &&
      blog.image != null) {
    return true;
  }
  return false;
}
