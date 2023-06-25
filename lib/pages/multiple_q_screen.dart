import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';
import '../modules/multipe_choice/quizBrainMultiple.dart';
import '../constants.dart';


class MultiQScreen extends StatefulWidget {
  const MultiQScreen({Key? key}) : super(key: key);

  @override
  State<MultiQScreen> createState() => _MultiQScreenState();
}

class _MultiQScreenState extends State<MultiQScreen> {
  QuizBrainMulti quizBrainMulti=QuizBrainMulti();
  List<Icon> scoreKeeper=[];
  int? _choice;
  int counter=10;
  late  Timer timer;
  bool? isCorrect=null;

  void checkAnswer(int? userChoice) {
    int correctAnswer = quizBrainMulti.getQuestionAnswer();
    timer.cancel();
    setState(() {initState(){
      if (correctAnswer == userChoice) {

          isCorrect=true;

          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );

      } else {
        isCorrect=false;
       initState(){
         scoreKeeper.add(
         const  Icon(
             Icons.close,
             color: Colors.red,
           ),
         );
       }}
      }
    });

    if (quizBrainMulti.isFinished()) {
      print('finished');
      timer.cancel();

      Timer(const Duration(seconds: 1), () {
        // Alert(context: context, title: "Finished", desc: "you are done").show();
        setState(() {
          quizBrainMulti.reset();
          scoreKeeper.clear();
          isCorrect=null;
          userChoice= null;
          counter=10;
        });
      });
    } else {
      quizBrainMulti.nextQuestion();
    }
  }



  void feedbackAlert(){
    AlertDialog(
      title:const Text("finished"),
      content: const Text("you are done"),
      actions: [
        ElevatedButton(onPressed: (){Navigator.of(context).pop(); }, child: const Text("Finish")),
      ],
      
    );
    
  }

  void startTimer(){
    timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // counter--;
      });
      if(counter==0){
        quizBrainMulti.nextQuestion();
      }
    });
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {

      setState(() {
        counter--;
      });
      if (counter == 0) {

        counter = 10;
        quizBrainMulti.nextQuestion();
      }

    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var questionNumber = 5;
    var questionsCount = 10;
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      },
                    ),
                  ),
                  // OutlinedButton(
                  //   onPressed: () {},
                  //   style: ButtonStyle().copyWith(
                  //     shape: MaterialStatePropertyAll(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(25),
                  //       ),
                  //     ),
                  //     side: MaterialStatePropertyAll(
                  //       BorderSide(color: Colors.white),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.favorite,
                  //         color: Colors.white,
                  //       ),
                  //       SizedBox(
                  //         width: 8,
                  //       ),
                  //       const Text(
                  //         '3',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/ballon-b.png'),
                ),
              ),
              Text(
               "question" // .quizBrainMulti.questionNumber()." of ".$questionsCount,
               , style:const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white60,
                ),
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
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _choice=3;
                      checkAnswer(_choice);
                    },);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  child:const Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Bremen',
                            style: TextStyle(
                                color: kL2,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_rounded,
                        color: kL2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                onPressed: () {
                  setState(() {
                  _choice=3;
                  checkAnswer(_choice);
                  },);},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  child:const Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Bremen',
                            style: TextStyle(
                                color: kL2,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_rounded,
                        color: kL2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(

                  onPressed: () {
                    setState(() {
                      _choice=3;
                      checkAnswer(_choice);
                    });


                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kG1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  child:const Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Gaza',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              ElevatedButton(
                onPressed: (){
                   startTimer();
                  _choice=null;
                  isCorrect=null;
                  counter=10;
                },
                child: Text("Next"),
              ),
              SizedBox(height: 50,child: Row(children: scoreKeeper,),)
            ],
          ),
        ),
      ),
    );
  }
}
