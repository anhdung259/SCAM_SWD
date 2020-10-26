import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/QuestionReview.dart';
import 'package:swd_project/Model/QuestionReviewResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class QuestionList {
  Repository _questionRepository = Repository();
  final BehaviorSubject<QuestionReviewResponse> _subject =
      BehaviorSubject<QuestionReviewResponse>();
  final BehaviorSubject<int> _size = BehaviorSubject<int>();
  // Function(int) get nameChangedStream => nameStreamController.sink.add;
  getQuestions() async {
    QuestionReviewResponse listQuestion =
        await _questionRepository.getListQuestion();
    _subject.sink.add(listQuestion);
  }

  getSizeListText() {
    print(_size.value);
    return _size.value;
  }

  getListTextQuestion() async {
    QuestionReviewResponse listQuestion =
        await _questionRepository.getListQuestion();
    List<QuestionReview> listQuestionAllType = listQuestion.questions;
    List<QuestionReview> listTextQuestion = List<QuestionReview>();
    for (int i = 0; i < listQuestionAllType.length; i++) {
      if (listQuestionAllType[i].questionType.contains('Text')) {
        listTextQuestion.add(listQuestionAllType[i]);
      }
    }
    print(listTextQuestion.length);
    _size.sink.add(listTextQuestion.length);
  }
  //   _listTextQuestion.sink.add(listTextQuestion);
  //   print(_listTextQuestion.value.length);
  // }

  dispose() {
    _subject.close();
    _size.close();
  }

  BehaviorSubject<QuestionReviewResponse> get subject => _subject.stream;
  BehaviorSubject<int> get sizeList => _size.stream;
}

final questionBloc = QuestionList();
