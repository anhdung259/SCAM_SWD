import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/QuestionReview.dart';
import 'package:swd_project/Model/QuestionReviewResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class QuestionList {
  Repository _productRepository = Repository();
  final BehaviorSubject<QuestionReviewResponse> _subject =
      BehaviorSubject<QuestionReviewResponse>();
  final BehaviorSubject<List<QuestionReview>> _listTextQuestion =
      BehaviorSubject<List<QuestionReview>>();
  final BehaviorSubject<List<QuestionReview>> _listRatingQuestion =
      BehaviorSubject<List<QuestionReview>>();
  final BehaviorSubject<List<QuestionReview>> _listYesNoQuestion =
      BehaviorSubject<List<QuestionReview>>();
  final BehaviorSubject<List<QuestionReview>> _listMultipleQuestion =
      BehaviorSubject<List<QuestionReview>>();

  getQuestions() async {
    QuestionReviewResponse listQuestion =
        await _productRepository.getListQuestion();
    _subject.sink.add(listQuestion);
  }

  getListTextQuestion() async {
    QuestionReviewResponse listQuestion =
        await _productRepository.getListQuestion();
    List<QuestionReview> listQuestionAllType = listQuestion.questions;
    List<QuestionReview> listTextQuestion = List<QuestionReview>();
    for (int i = 0; i < listQuestionAllType.length; i++) {
      if (listQuestionAllType[i].questionType.contains('Text')) {
        listTextQuestion.add(listQuestionAllType[i]);
      }
    }
    _listTextQuestion.sink.add(listTextQuestion);
    print(_listTextQuestion.value.length);
  }

  int getSize() {
    List<QuestionReview> list = _listTextQuestion.value;
    var size = list.length;
    return size;
  }

  getListRatingQuestion() async {
    QuestionReviewResponse listQuestion =
        await _productRepository.getListQuestion();
    List<QuestionReview> listQuestionAllType = listQuestion.questions;
    List<QuestionReview> listTextQuestion = List<QuestionReview>();
    for (int i = 0; i < listQuestionAllType.length; i++) {
      if (listQuestionAllType[i].questionType.contains('Rating scale')) {
        listTextQuestion.add(listQuestionAllType[i]);
      }
    }
    _listRatingQuestion.sink.add(listTextQuestion);
  }

  getListYesNoQuestion() async {
    QuestionReviewResponse listQuestion =
        await _productRepository.getListQuestion();
    List<QuestionReview> listQuestionAllType = listQuestion.questions;
    List<QuestionReview> listTextQuestion = List<QuestionReview>();
    for (int i = 0; i < listQuestionAllType.length; i++) {
      if (listQuestionAllType[i].questionType.contains('Yes/No')) {
        listTextQuestion.add(listQuestionAllType[i]);
      }
    }
    _listYesNoQuestion.sink.add(listTextQuestion);
  }

  getListMultipleQuestion() async {
    QuestionReviewResponse listQuestion =
        await _productRepository.getListQuestion();
    List<QuestionReview> listQuestionAllType = listQuestion.questions;
    List<QuestionReview> listMultipleQuestion = List<QuestionReview>();
    for (int i = 0; i < listQuestionAllType.length; i++) {
      if (listQuestionAllType[i].questionType.contains('Multiple choice')) {
        listMultipleQuestion.add(listQuestionAllType[i]);
      }
    }
    _listMultipleQuestion.sink.add(listMultipleQuestion);
  }

  dispose() {
    _subject.close();
    _listTextQuestion.close();
    _listYesNoQuestion.close();
    _listRatingQuestion.close();
    _listMultipleQuestion.close();
  }

  BehaviorSubject<QuestionReviewResponse> get subject => _subject.stream;

  BehaviorSubject<List<QuestionReview>> get listTextQuestion =>
      _listTextQuestion.stream;

  BehaviorSubject<List<QuestionReview>> get listYesNoQuestion =>
      _listYesNoQuestion.stream;

  BehaviorSubject<List<QuestionReview>> get listRatingQuestion =>
      _listRatingQuestion.stream;

  BehaviorSubject<List<QuestionReview>> get listMultipleQuestion =>
      _listMultipleQuestion.stream;
}

final questionBloc = QuestionList();
