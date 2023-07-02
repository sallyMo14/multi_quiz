import 'package:multi_quiz_s_t_tt9/modules/true_false/questionTrueOrFalse.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _questionTotal = 0;

  final List<Question> _questionBank = [
    Question('In the animation film “Finding Nemo,” the main protagonist is a pufferfish.', false),
    Question('Is Mount Kilimanjaro the world’s tallest peak?', false),
    Question('Spaghetto is the singular form of the word spaghetti', true),
    Question('Pinocchio was Walt Disney’s first animated feature film in full color. ', false),
    Question('Venezuela is home to the world’s highest waterfall. ', true),
    Question('Coffee is a berry-based beverage. ', true),
    Question('The capital of Australia is Sydney. ', false),
    Question('The longest river in the world is the Amazon River', false),
    Question('Polar bears can only live in the Arctic region, not in the Antarctic', true),
    Question('The United Kingdom is almost the same size as France.', false),
  ];

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getQuestionCount(){
    return _questionBank.length;
  }
  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }
  int getQuestionNumber(){
    return _questionNumber;
  }
  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
