import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/ReviewAnswer.dart';

class ReviewBloc {
  BehaviorSubject<ReviewAnswer> _Text = BehaviorSubject<ReviewAnswer>();
  BehaviorSubject<ReviewAnswer> _ReviewAnswer = BehaviorSubject<ReviewAnswer>();
  BehaviorSubject<int> _Id = BehaviorSubject<int>();
  BehaviorSubject<List<TextEditingController>> _listTextEditController =
      BehaviorSubject<List<TextEditingController>>();
  Function(ReviewAnswer) get getTextL => _Text.sink.add;
  Function(int) get getID => _Id.sink.add;
  List<String> listText = List<String>();

  addText(String TextF) {
    print(TextF);
  }

  printText() {
    print(_Text.value.answer);
    print(_Text.value.questionId);
  }

  printList() {
    for (int i = 0; i < listText.length; i++) {
      print(listText[i]);
    }
  }

  dispose() {
    _Text.close();
    _Id.close();
    _ReviewAnswer.close();
    _listTextEditController.close();
  }
}

final reviewbloc = ReviewBloc();
