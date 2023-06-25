import 'package:flutter/cupertino.dart';

class Level {
  IconData? icon;
  String? title;
  String? subTitle;
  String? description;
  String? image;
  List<Color> color1;
  String routeName;

  Level(
      {required this.icon,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.color1,
      required this.description,
      required this.routeName});
}
