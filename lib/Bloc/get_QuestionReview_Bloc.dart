import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/QuestionReview/QuestionReviewResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class QuestionList {
  Repository _questionRepository = Repository();
  final BehaviorSubject<QuestionReviewResponse> _subject =
      BehaviorSubject<QuestionReviewResponse>();

  // Function(int) get nameChangedStream => nameStreamController.sink.add;
  getQuestions() async {
    QuestionReviewResponse listQuestion =
        await _questionRepository.getListQuestion();
    _subject.sink.add(listQuestion);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<QuestionReviewResponse> get subject => _subject.stream;
}

final questionBloc = QuestionList();
