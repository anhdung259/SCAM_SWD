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

  getReviewFilter(int id, int currentPage, int pageSize, String filter) async {
    ReviewResponse listReview = await _reviewRepository.getListReviewFilter(
        id, currentPage, pageSize, filter);
    listAll.addAll(listReview.reviews);
    _subject.sink.add(listAll);
  }

//to update review
  getReviewUser(int productId) async {
    ReviewUpdateResponse review =
        await _reviewRepository.getReviewUserUpdate(productId);
    _reviewUser.sink.add(review);
  }

  Future<int> getSizeListReview(int id) async {
    ReviewResponse listReview = await _reviewRepository.getListReview(id);
    return listReview.reviews.length;
  }

  Future<bool> checkReview(int productId) async {
    ReviewUpdateResponse reviewUpdateResponse =
        await _reviewRepository.getReviewUserUpdate(productId);
    if (reviewUpdateResponse.review.rate == null) {
      return false;
    }
    return true;
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

  dispose() async {
    _subject.close();
    _reviewUser.close();
  }

  BehaviorSubject<List<Review>> get subject => _subject.stream;
  BehaviorSubject<ReviewUpdateResponse> get reviewUser => _reviewUser.stream;
}

final reviewByIdBloc = ReviewList();
