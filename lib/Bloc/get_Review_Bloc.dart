import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewList.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewResponse.dart';

import 'package:swd_project/Repository/Repository.dart';

class ReviewList {
  List<Review> listAll = [];
  Repository _reviewRepository = Repository();
  final BehaviorSubject<List<Review>> _subject =
      BehaviorSubject<List<Review>>();

  // Function(int) get nameChangedStream => nameStreamController.sink.add;
  getReview(int id, int currentPage, int pageSize) async {
    ReviewResponse listReview = await _reviewRepository.getListReviewInProduct(
        id, currentPage, pageSize);
    listAll.addAll(listReview.reviews);
    _subject.sink.add(listAll);
  }

  void dainStream() {
    listAll.clear();
    _subject.value = null;
  }

  //   _listTextQuestion.sink.add(listTextQuestion);
  //   print(_listTextQuestion.value.length);
  // }

  dispose() async {
    _subject.close();
  }

  BehaviorSubject<List<Review>> get subject => _subject.stream;
}

final reviewByIdBloc = ReviewList();
