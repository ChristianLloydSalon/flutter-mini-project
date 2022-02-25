import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/blog/initial_blogs.dart';
import '../../domain/model/blog.dart';

final blogsViewModelProvider = ChangeNotifierProvider<BlogsViewModel>((ref) {
  final initialData = ref.watch(initialBlogsProvider);
  return BlogsViewModel(initialData);
});

class BlogsViewModel extends ChangeNotifier {
  List<Blog> _blogs = [];
  List<Blog> get blogPosts => _blogs;

  late final InitialBlogs _initialData;

  BlogsViewModel(InitialBlogs initialData) {
    _initialData = initialData;
  }

  Future<void> initializeBlogs() async {
    final data = await _initialData.initialBlogs();
    _blogs = data;
  }

  Future<void> addBlog(Blog blog) async {
    _blogs.add(blog);
    notifyListeners();
  }

  Future<void> deleteBlog(Blog blog) async {
    _blogs.removeWhere((b) => blog.id == b.id);
    notifyListeners();
  }

  Future<void> updateBlog(Blog blog) async {
    _blogs[_blogs.indexWhere((element) => element.id == blog.id)] = blog;
    notifyListeners();
  }
}