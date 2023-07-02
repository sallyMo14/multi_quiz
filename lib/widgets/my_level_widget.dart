import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/constants.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

import '../modules/level_inf.dart';

class MyLevelWidget extends StatelessWidget {
  final Level level;

  final Function() function;



   MyLevelWidget({
    Key? key,
    required this.level,
    required this.function,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: level.isEnabled ? function : null,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 54, bottom: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: level.isEnabled?  level.color_if_Enabled : level.color_if_locked,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      level.title!,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: kFontFamily,
                      ),
                    ),
                    Container(
                        width: 50,
                        height: 50,
                        child: level.isEnabled? SizedBox( child: Text(""),):  Image.asset("assets/images/lock.png",) ,
                        // child: Image.asset("assets/images/lock.png",),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 28.0),
            child:level.isEnabled?  Image.asset(level.image!):SizedBox(),
          ),

        ],
      ),
    );
  }
}
