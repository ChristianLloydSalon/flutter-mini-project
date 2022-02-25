import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Character {
  String? _id;
  String? _name;
  String? _image;
  String? _gender;

  String? get id => _id;

  String? get name => _name;

  String? get image => _image;

  IconData? get gender => (_gender == 'Male')
      ? FontAwesomeIcons.male
      : (_gender == 'Female')
          ? FontAwesomeIcons.female
          : (_gender == 'Genderless')
              ? FontAwesomeIcons.genderless
              : FontAwesomeIcons.question;

  Character({
    String? id,
    String? name,
    String? image,
    String? gender,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _gender = gender;
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      gender: json['gender'] as String,
    );
  }
}
