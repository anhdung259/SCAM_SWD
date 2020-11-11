import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewList.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewResponse.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewUpdateResponse.dart';

import 'package:swd_project/Repository/Repository.dart';

class ReviewList {
  List<Review> listAll = [];
  Repository _reviewRepository = Repository();
  final BehaviorSubject<List<Review>> _subject =
      BehaviorSubject<List<Review>>();
  final BehaviorSubject<ReviewUpdateResponse> _reviewUser =
      BehaviorSubject<ReviewUpdateResponse>();
  // Function(int) get nameChangedStream => nameStreamController.sink.add;
  getReview(int id, int currentPage, int pageSize) async {
    ReviewResponse listReview = await _reviewRepository.getListReviewInProduct(
        id, currentPage, pageSize);
    listAll.addAll(listReview.reviews);
    _subject.sink.add(listAll);
  }

  getReviewFilter(int id, int currentPage, int pageSize, int rate1, int rate2,
      int rate3, int rate4, int rate5) async {
    ReviewResponse listReview = await _reviewRepository.getListReviewFilter(
        id, currentPage, pageSize, rate1, rate2, rate3, rate4, rate5);
    listAll.addAll(listReview.reviews);
    _subject.sink.add(listAll);
  }

//to update review
  getReviewUser(int reviewId) async {
    ReviewUpdateResponse review =
        await _reviewRepository.getReviewUserUpdate(reviewId);
    _reviewUser.sink.add(review);
  }

  Future<int> getSizeListReview(int id) async {
    ReviewResponse listReview = await _reviewRepository.getListReview(id);
    return listReview.reviews.length;
  }

  Future<List<Review>> getAllList(int id) async {
    ReviewResponse listReview = await _reviewRepository.getListReview(id);
    return listReview.reviews;
  }

  void dainStream() {
    listAll.clear();
    _reviewUser.value = null;
    _subject.value = null;
  }

  //   _listTextQuestion.sink.add(listTextQuestion);
  //   print(_listTextQuestion.value.length);
  // }

  dispose() async {
    _subject.close();
    _reviewUser.close();
  }

  BehaviorSubject<List<Review>> get subject => _subject.stream;
  BehaviorSubject<ReviewUpdateResponse> get reviewUser => _reviewUser.stream;
}

final reviewByIdBloc = ReviewList();
