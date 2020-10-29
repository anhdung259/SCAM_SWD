import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/ReviewResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class ReviewList {
  Repository _reviewRepository = Repository();
  final BehaviorSubject<ReviewResponse> _subject =
      BehaviorSubject<ReviewResponse>();

  // Function(int) get nameChangedStream => nameStreamController.sink.add;
  getReview(int id) async {
    ReviewResponse listReview =
        await _reviewRepository.getListReviewInProduct(id);
    _subject.sink.add(listReview);
  }

  //   _listTextQuestion.sink.add(listTextQuestion);
  //   print(_listTextQuestion.value.length);
  // }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ReviewResponse> get subject => _subject.stream;
}

final reviewByIdBloc = ReviewList();
