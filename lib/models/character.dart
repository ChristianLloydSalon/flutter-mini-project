class Character {
  String? _id;
  String? _name;
  String? _image;

  String? get id => _id;

  String? get name => _name;

  String? get image => _image;

  Character({
    String? id,
    String? name,
    String? image,
  }) {
    _id = id;
    _name = name;
    _image = image;
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
}
