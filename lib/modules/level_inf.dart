import 'package:flutter/cupertino.dart';

class Level {
  IconData? icon;
  String? title;
  String? subTitle;
  String? description;
  String? image;
  List<Color> color_if_Enabled;
  List<Color>  color_if_locked;
  int requiredScore;

  String routeName;
  bool isEnabled ;

  Level(
      {required this.icon,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.color_if_Enabled,
      required this.description,
      required this.routeName,
      this.isEnabled = false,
      required this.color_if_locked,
      required this.requiredScore});
}
