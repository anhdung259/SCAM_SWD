import 'ReviewAnswer.dart';
import 'UserReview.dart';

class Review {
  Review({
    this.id,
    this.productId,
    this.userId,
    this.completeOn,
    this.status,
    this.user,
    this.reviewAnswers,
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
      );
}
