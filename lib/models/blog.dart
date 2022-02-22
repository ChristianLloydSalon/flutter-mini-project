import 'dart:typed_data';

class Blog {
  late String id;
  late String title;
  late String subtitle;
  late String content;
  late String date;
  late Uint8List? image;

  Blog({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.date,
    required this.image,
  });
}
