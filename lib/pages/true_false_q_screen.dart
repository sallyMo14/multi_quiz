import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';
import '../modules/true_false/quizBrain.dart';
import '../widgets/my_outline_btn.dart';
import 'home.dart';

class TrueFalseQuiz extends StatefulWidget {
  @override
  _TrueFalseQuizState createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];
  bool? choice;
  int counter = 10;
  bool? iscorrect;
  late Timer timer;
  bool? userchoice;
  int iconTrue = 0;
  int totalQuestion = 0;

  void checkAnswer(bool choice) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    cancelTimer();
    setState(
      () {
        if (correctAnswer == choice) {
          iscorrect = true;
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          iconTrue++;
        } else {
          iscorrect = false;
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
      },
    );
  }

  void next() {
    if (quizBrain.isFinished()) {
      print('finished');
      cancelTimer();
      alertFinish();
    } else {
      counter = 10;
      startTimer();
      iscorrect = null;
      choice = null;
    }
    setState(() {
      iscorrect = null;
      choice = null;
      quizBrain.nextQuestion();
    });
  }

  void startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          counter--;
        });
        if (counter == 0) {
          next();
        }
        ;
      },
    );
  }

  void alertFinish() {
    Alert(
        context: context,
        title: 'Finished',
        desc: 'Your score : $iconTrue from $totalQuestion ',
        closeIcon: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrueFalseQuiz(),
              ),
            );
            setState(() {
              counter = 10;
              choice = null;
              userchoice = null;
            });
          },
          icon: Icon(Icons.close),
        ),
        buttons: [
          DialogButton(
            child: const Text('Finished'),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          )
        ]).show();
  }

  void cancelTimer() {
    timer.cancel();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
    totalQuestion = quizBrain.getQuestionNumberTotal();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kL1,
              kRedFont,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 74, left: 24, right: 24),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: MYOutlineBtn(
                      icon: Icons.close,
                      iconColor: Colors.white,
                      bColor: Colors.white,
                      function: () {
                        // Navigator.pop(context);
                        // Navigator.pop(context);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: CircularProgressIndicator(
                          value: counter / 10,
                          color: Colors.white,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                      Text(
                        counter.toString(),
                        style: TextStyle(
                          fontFamily: 'Sf-Pro-Text',
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: BorderSide(color: Colors.white)),
                  )
                ],
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: -1,
                child: Container(
                  width: 200,
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: choice == null
                            ? () {
                                choice = true;
                                checkAnswer(true);
                                userchoice = true;
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: iscorrect == null
                                ? Colors.white
                                : (iscorrect == true && userchoice == true)
                                    ? Colors.green
                                    : iscorrect == false && userchoice == true
                                        ? Colors.red
                                        : Colors.white,
                            backgroundColor: iscorrect == null
                                ? Colors.white
                                : (iscorrect == true && userchoice == true)
                                    ? Colors.green
                                    : iscorrect == false && userchoice == true
                                        ? Colors.red
                                        : Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Center(
                              child: Text(
                                'True',
                                style: TextStyle(
                                  color: kRedFont,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            iscorrect == null
                                ? SizedBox()
                                : iscorrect == true
                                    ? Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                      )
                                    : iscorrect == false
                                        ? Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          )
                                        : SizedBox(),
                          ],
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: -1,
                child: Container(
                  width: 200,
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: choice == null
                            ? () {
                                choice = false;
                                checkAnswer(false);
                                userchoice = false;
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: iscorrect == null
                                ? Colors.white
                                : (iscorrect == true && userchoice == false)
                                    ? Colors.green
                                    : iscorrect == false && userchoice == false
                                        ? Colors.red
                                        : Colors.white,
                            backgroundColor: iscorrect == null
                                ? Colors.white
                                : iscorrect == true && userchoice == false
                                    ? Colors.green
                                    : iscorrect == false && userchoice == false
                                        ? Colors.red
                                        : iscorrect = null,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Center(
                              child: Text(
                                'False',
                                style: TextStyle(
                                  color: kRedFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            iscorrect == null
                                ? SizedBox()
                                : iscorrect == true
                                    ? Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                      )
                                    : iscorrect == false
                                        ? Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          )
                                        : SizedBox(),
                          ],
                        )),
                  ),
                ),
              ),

              Wrap(
                children: scoreKeeper,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (quizBrain.isFinished()) {
                        print('finished');
                        cancelTimer();
                        timer = Timer(Duration(seconds: 1), () {
                          alertFinish();
                          setState(() {
                            quizBrain.reset();
                            scoreKeeper.clear();
                            iscorrect = null;
                            choice = null;
                            counter = 10;
                          });
                        });
                      } else {
                        next();
                        iscorrect = null;
                        choice = null;
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
              // MYOutlineBtn(icon: null, function: () {  }, bColor: null, iconColor: null,)
            ],
          ),
        ),
      ),
    );
  }
}
