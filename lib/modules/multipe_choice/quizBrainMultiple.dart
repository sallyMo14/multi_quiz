import 'package:multi_quiz_s_t_tt9/modules/multipe_choice/questionMultiple.dart';

class QuizBrainMulti {
  int _questionNumber = 0;

  final List<QuestionMultiple> _questionBank = [
    QuestionMultiple('You can lead a cow down stairs but not up stairs.',
        0,
        ['always', 'never', 'sometimes']),
    QuestionMultiple(
        'Approximately one quarter of human bones are in the feet.',
        1,
        ['agree', 'disagree', 'not sure']),
    QuestionMultiple('You can lead a cow down stairs but not up stairs.',
        2,
        ['always', 'never', 'sometimes']),
    QuestionMultiple(
        'Approximately one quarter of human bones are in the feet.',
        0,
        ['agree', 'disagree', 'not sure']),
    QuestionMultiple('You can lead a cow down stairs but not up stairs.',
        1,
        ['always', 'never', 'sometimes']),
    QuestionMultiple(
        'Approximately one quarter of human bones are in the feet.',
        2,
        ['agree', 'disagree', 'not sure']),
  ];

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  int getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  List<String> getOptions() {
    return _questionBank[_questionNumber].options;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }
  int getQuestionCount(){
    return _questionBank.length;
  }
  int getQuestionNumber(){
    return _questionNumber;
  }
  void reset() {
    _questionNumber = 0;
  }
}
