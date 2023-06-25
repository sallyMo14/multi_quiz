import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/pages/true_false_q_screen.dart';

import '../constants.dart';
import '../modules/true_false/level_inf.dart';
import '../widgets/my_outline_btn.dart';
import 'multiple_q_screen.dart';

class LevelDescription extends StatelessWidget {
  final Level levelInf;

  const LevelDescription({Key? key, required this.levelInf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var questionNumber = 5;
    var questionsCount = 10;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: levelInf.color1!,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 74, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: MYOutlineBtn(
                      icon: levelInf.icon!,
                      iconColor: Colors.white,
                      bColor: Colors.white,
                      function: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset(levelInf.image!),
                ),
              ),
              Text(
                'question $questionNumber of $questionsCount',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white60,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'In Which City of Germany Is the Largest Port?',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'question  dhjvajak jklfsakljvabvjkfabjsk \n cdklbvcjksabcddhsaj',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white60,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, levelInf.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  child: Expanded(
                    child: Center(
                      child: Text(
                        'Game',
                        style: TextStyle(
                            color: levelInf.color1[0],
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
