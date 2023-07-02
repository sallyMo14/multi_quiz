import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../modules/multipe_choice/quizBrainMultiple.dart';
import '../constants.dart';


class MultiQScreen extends StatefulWidget {
  const MultiQScreen({Key? key}) : super(key: key);

  @override
  State<MultiQScreen> createState() => _MultiQScreenState();
}

class _MultiQScreenState extends State<MultiQScreen> {
  // todo: statatic here may couse something
  static QuizBrainMulti quizBrainMulti=QuizBrainMulti();
  List<Icon> scoreKeeper=[];
  int? _choice;
  int counter=10;
  late  Timer timer;
  bool? isCorrect = null;
  int _corrwctAnswersNo = 0 ;
  int _nuOfQuestions=quizBrainMulti.getQuestionCount();
  List<String> options= quizBrainMulti.getOptions();



  @override
  void initState() {
    startTimer();
    quizBrainMulti.reset();
    super.initState();
  }
  void startTimer(){
    timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter--;
      },);
      if(counter==0){
        next();
        // _choice=null;
      }
    },);
  }
  void checkAnswer(int? userChoice) {
    int correctAnswer = quizBrainMulti.getQuestionAnswer();
    timer.cancel();
    setState(() {
      if (correctAnswer == userChoice) {

          isCorrect=true;
          _corrwctAnswersNo++;
          score++;
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );

      } else {
        isCorrect=false;

         scoreKeeper.add(
         const  Icon(
             Icons.close,
             color: Colors.red,
           ),
         );
       }

    });


  }
  void next() {
    if (quizBrainMulti.isFinished()) {

      print('finished');
      timer.cancel();
      feedbackAlert();
      quizBrainMulti.reset();
    } else {



      setState(() {
         isCorrect = null;
        _choice = null;
        quizBrainMulti.nextQuestion();
        counter=10;
      });
    }

  }
  void feedbackAlert(){
    if(_corrwctAnswersNo/quizBrainMulti.getQuestionCount() > .9){
      setState(() {
        lvl2IsFinished=true;
      });

    }
    Alert (
        context: context,
        title: 'Finished',
        desc: 'Your score : $_corrwctAnswersNo from $_nuOfQuestions',
        closeIcon: IconButton(
          onPressed: () {
            quizBrainMulti.reset();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiQScreen(),
              ),
            );
            setState(() {
              quizBrainMulti.reset();
              scoreKeeper.clear();
              isCorrect=null;
              _choice= null;
              counter=10;

            });
          },
          icon: Icon(Icons.close,),
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
  Color ButtonColor(correctChoice){
    Color color=
    isCorrect == null
        ? Colors.white
        : (isCorrect == true && _choice ==correctChoice )
        ? kG1
        : (isCorrect == false && _choice == correctChoice)
        ? kRedFont
        : Colors.white;
    return color;
  }










  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kBlueBg,
              kL2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 74, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                            builder: (context) =>const HomePage(),
                          ),
                          (route) => false,
                        );
                        quizBrainMulti.reset();
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
                          value: counter/10,
                          color: Colors.white,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                       Text(
                        "$counter"
                            ,
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
                        side:const BorderSide(color: Colors.white)),
                  )
                ],
              ),
              SizedBox(height: 12,),
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/ballon-b.png'),
                ),
              ),
              SizedBox(height: 12,),
              Row(
                children: [
                  Text(

                   "question ${quizBrainMulti.getQuestionNumber()+1} of ${quizBrainMulti.getQuestionCount()}",
                    style:const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Sf-Pro-Text',
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
             const SizedBox(
                height: 8,
              ),
               Text(
                quizBrainMulti.getQuestionText(),
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
             const SizedBox(
                height: 48,
              ),



            Padding(
              padding: const EdgeInsets.all(4),

                child:Row(
                  children: [
                    Expanded(

                      child: ElevatedButton(
                        onPressed:
                             _choice == null ? () {
                              _choice = 0;
                             checkAnswer(_choice);
                            if(quizBrainMulti.isFinished()){
                              Timer(Duration(seconds: 1), () {feedbackAlert(); });

                            }


                            // _choice = null;
                          } : null,
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: isCorrect == null
                                ? Colors.white
                                : (isCorrect == true && _choice == 0 )
                                ? Colors.green
                                : isCorrect == false && _choice == 0
                                ? Colors.red
                                : Colors.white,
                            backgroundColor: isCorrect == null
                                ? Colors.white
                                : (isCorrect == true && _choice == 0)
                                ? Colors.green
                                : isCorrect == false && _choice == 0
                                ? Colors.red
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 16,
                            )),
                        child: Container(
                          width: 200,
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Center(
                                  child: Text(
                                    options[0],
                                    style: TextStyle(
                                      color: _choice==0 ? Colors.white : kBlueBg,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                isCorrect == null
                                    ? SizedBox()
                                    : isCorrect == true
                                    ? Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                )
                                    : isCorrect == false
                                    ? Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )
                                    : SizedBox(),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ],
                ),

            ),
            Padding(
              padding: const EdgeInsets.all(4),

                child:Row(
                  children: [
                    Expanded(

                      child: ElevatedButton(
                        onPressed:
                            _choice == null ? () {
                              _choice = 1;
                              checkAnswer(_choice);
                              if(quizBrainMulti.isFinished()){
                                Timer(Duration(seconds: 1), () {feedbackAlert(); });

                              }
                            // _choice = null;
                          } : null,

                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: isCorrect == null
                                ? Colors.white
                                : (isCorrect == true && _choice == 1)
                                ? Colors.green
                                : isCorrect == false && _choice == 1
                                ? Colors.red
                                : Colors.white,
                            backgroundColor: isCorrect == null
                                ? Colors.white
                                : (isCorrect == true && _choice == 1)
                                ? Colors.green
                                : isCorrect == false && _choice == 1
                                ? Colors.red
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 16,
                            )),
                        child: Container(
                          width: 200,
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Center(
                                  child: Text(
                                    options[1],
                                    style: TextStyle(
                                      color: _choice==1 ? Colors.white : kBlueBg,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                isCorrect == null
                                    ? SizedBox()
                                    : isCorrect == true
                                    ? Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                )
                                    : isCorrect == false
                                    ? Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )
                                    : SizedBox( width: 24,),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ],
                ),

            ),
            Padding(
              padding: const EdgeInsets.all(4),

                child:Row(
                  children: [
                    Expanded(

                      child: ElevatedButton(
                        onPressed:
                            _choice == null ? () {
                              _choice = 2;
                              checkAnswer(_choice);
                              if(quizBrainMulti.isFinished()){
                                Timer(Duration(seconds: 1), () {feedbackAlert(); });

                              }
                            // _choice = null;
                          } : null,
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: isCorrect == null
                                ? Colors.white
                                : (isCorrect == true && _choice == 2)
                                ? Colors.green
                                : isCorrect == false && _choice == 2
                                ? Colors.red
                                : Colors.white,
                            backgroundColor: isCorrect == null
                                ? Colors.white
                                : (isCorrect == true && _choice == 2)
                                ? Colors.green
                                : isCorrect == false && _choice == 2
                                ? Colors.red
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(
                              vertical:4,
                              horizontal: 16,
                            )),
                        child: Container(
                          width: 200,
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Center(
                                  child: Text(
                                    options[2],
                                    style: TextStyle(
                                      color: _choice==2 ? Colors.white : kBlueBg,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                isCorrect == null
                                    ? SizedBox()
                                    : isCorrect == true
                                    ? Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                )
                                    : isCorrect == false
                                    ? Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )
                                    : SizedBox(),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ],
                ),

            ),


              SizedBox(
                child: _choice==null||quizBrainMulti.isFinished() ? Container(height: 57,) :  Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0 ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    onPressed: (){
                      next();
                      startTimer();
                      // _choice=null;
                    },
                    child: Text("Next",style: TextStyle(),),
                  ),//kL2
                ),
              ),
              SizedBox(height: 50,child: Row(children: scoreKeeper,),)
            ],
          ),
        ),
      ),
    );
  }
}


















