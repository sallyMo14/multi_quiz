import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/constants.dart';
import 'package:multi_quiz_s_t_tt9/modules/level_inf.dart';
import 'package:multi_quiz_s_t_tt9/modules/level_inf.dart';
import 'package:multi_quiz_s_t_tt9/pages/level_describtion.dart';
import 'package:multi_quiz_s_t_tt9/pages/multiple_q_screen.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

import '../widgets/my_level_widget.dart';
int score=0;
bool lvl1IsFinished =false;
bool lvl2IsFinished = false;
int getScore(){
  return score;
}
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Level> lvl = [
    Level(
      icon: lvl1IsFinished  ? Icons.check : Icons.play_arrow,
      title: 'True or False',
      subTitle: 'Level 1',
      image: 'assets/images/bags.png',
      description: 'Rise Up your IQ',
      color_if_Enabled: [kL1, kL12],
      routeName: '/level1',
      isEnabled: true,
      color_if_locked: [kL1, kL12],
      requiredScore: 0
    ),
    Level(
      icon: lvl2IsFinished  ? Icons.check : Icons.play_arrow,
      title: 'Multiple Choice',
      subTitle: 'Level 2',
      image: 'assets/images/ballon-s.png',
      description: 'Rise Up your IQ',
      color_if_Enabled: [kL2, kL22],
      routeName: '/level2',
      color_if_locked: [kL1BW,kL1BW],
      requiredScore: 6,
      isEnabled: score>6 ? true: false,

    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Your Score : $score",style: TextStyle(color: kBlueIcon ,
fontWeight: FontWeight.bold,fontSize: 18
        ),
        ),
        actions: [
          MYOutlineBtn(
            icon: Icons.favorite,
            iconColor: kBlueIcon,
            bColor: kGreyFont.withOpacity(0.5),
            function: () {
              print("11111");
            },
          ),
          MYOutlineBtn(
              icon: Icons.person,
              iconColor: kBlueIcon,
              bColor: kGreyFont.withOpacity(0.5),
              function: () {
                print("2222");
              }),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s Play',
              style: TextStyle(
                fontSize: 32,
                color: kRedFont,
                fontWeight: FontWeight.bold,
                fontFamily: kFontFamily,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Be the First!',
              style: TextStyle(
                fontSize: 18,
                color: kGreyFont,
                fontFamily: kFontFamily,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: lvl.length,
                  itemBuilder: (context, index) {
                    return MyLevelWidget(

                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LevelDescription(
                              levelInf: lvl[index],
                            ),
                          ),
                        );
                      },
                      level: lvl[index],

                    );
                  },),
            ),
          ],
        ),
      ),
    );
  }
}
