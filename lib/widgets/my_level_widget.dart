import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/constants.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

import '../modules/true_false/level_inf.dart';

class MyLevelWidget extends StatelessWidget {
  final Level level;

  final Function() function;
  // final IconData icon;
  // final String title;
  // final String subtitle;
  // final String image;
  // final List<Color> colors;

  const MyLevelWidget({
    Key? key,
    required this.level,
    required this.function,
    // required this.icon,
    // required this.title,
    // required this.subtitle,
    // required this.image,
    // required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 54, bottom: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: level.color1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 44,
                  width: 44,
                  child: MYOutlineBtn(
                    icon: level.icon!,
                    iconColor: Colors.white,
                    bColor: Colors.white,
                    function: () {},
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  level.subTitle!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                    fontFamily: kFontFamily,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  level.title!,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: kFontFamily,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 28.0),
            child: Image.asset(level.image!),
          ),
        ],
      ),
    );
  }
}
