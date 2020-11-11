import 'package:swd_project/Model/User/UserReview.dart';

import 'ReviewAnswer.dart';

class Review {
  Review({
    this.id,
    this.productId,
    this.userId,
    this.completeOn,
    this.status,
    this.user,
    this.reviewAnswers,
    this.userReviewMedia,
    this.rate,
  });

  int id;
  int productId;
  int userId;
  dynamic completeOn;
  bool status;
  User user;
  double rate;
  List<ReviewAnswer> reviewAnswers;
  List<UserReviewMedia> userReviewMedia;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        productId: json["productId"],
        userId: json["userId"],
        completeOn: json["completeOn"],
        status: json["status"],
        user: User.fromJson(json["user"]),
        rate: json["rate"],
        reviewAnswers: List<ReviewAnswer>.from(
            json["reviewAnswers"].map((x) => ReviewAnswer.fromJson(x))),
        userReviewMedia: List<UserReviewMedia>.from(
            json["userReviewMedia"].map((x) => UserReviewMedia.fromJson(x))),
      );
}
