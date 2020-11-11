import 'dart:convert';

import 'package:swd_project/Model/QuestionReview/QuestionReview.dart';

String answerPostToJson(AnswerPost data) => json.encode(data.toJson());

String answerUpdateToJson(AnswerUpdate data) => json.encode(data.toJson());

class Answer {
  int userReviewId;
  int questionId;
  String answer;
  dynamic status;

  Answer(this.userReviewId, this.questionId, this.answer, this.status);

  Map<String, dynamic> toJson() => {
        "userReviewId": userReviewId,
        "questionId": questionId,
        "answer": answer,
        "status": status
      };
}

class AnswerVer2 {
  int id;
  String answer;
  dynamic status;

  AnswerVer2(this.id, this.answer, this.status);

  Map<String, dynamic> toJson() =>
      {"id": id, "answer": answer, "status": status};
}

class ReviewAnswer {
  ReviewAnswer({
    this.id,
    this.userReviewId,
    this.questionId,
    this.answer,
    this.question,
    this.status,
  });

  int id;
  int userReviewId;
  int questionId;
  String answer;
  bool status;
  QuestionReview question;

  factory ReviewAnswer.fromJson(Map<String, dynamic> json) => ReviewAnswer(
        id: json["id"],
        userReviewId: json["userReviewId"],
        questionId: json["questionId"],
        answer: json["answer"],
        status: json["status"],
        question: QuestionReview.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userReviewId": userReviewId,
        "questionId": questionId,
        "answer": answer,
      };
}

class AnswerPost {
  AnswerPost({
    this.userReview,
    this.reviewAnswers,
    this.userReviewMedia,
  });

  UserReview userReview;
  List<Answer> reviewAnswers;
  List<UserReviewMedia> userReviewMedia;

  Map<String, dynamic> toJson() => {
        "userReview": userReview == null ? null : userReview.toJson(),
        "reviewAnswers": reviewAnswers == null
            ? null
            : List<dynamic>.from(reviewAnswers.map((x) => x.toJson())),
        "userReviewMedia": userReviewMedia == null
            ? []
            : List<dynamic>.from(userReviewMedia.map((x) => x.toJson())),
      };
}

class AnswerUpdate {
  AnswerUpdate({
    this.userUpdateReview,
    this.reviewAnswers,
    this.userReviewMedia,
  });

  UserUpdateReview userUpdateReview;
  List<AnswerVer2> reviewAnswers;
  List<UserReviewMedia> userReviewMedia;

  Map<String, dynamic> toJson() => {
        "userReview":
            userUpdateReview == null ? null : userUpdateReview.toJson(),
        "reviewAnswers": reviewAnswers == null
            ? null
            : List<dynamic>.from(reviewAnswers.map((x) => x.toJson())),
        "userReviewMedia": userReviewMedia == null
            ? []
            : List<dynamic>.from(userReviewMedia.map((x) => x.toJson())),
      };
}

class UserReviewMedia {
  UserReviewMedia({
    this.id,
    this.userReviewId,
    this.title,
    this.url,
    this.mediaType,
  });

  int id;
  int userReviewId;
  String title;
  String url;
  String mediaType;

  factory UserReviewMedia.fromJson(Map<String, dynamic> json) =>
      UserReviewMedia(
        id: json["id"],
        userReviewId: json["userReviewId"],
        title: json["title"],
        url: json["url"],
        mediaType: json["mediaType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userReviewId": userReviewId,
        "title": title,
        "url": url,
        "mediaType": mediaType,
      };
}

class UserReview {
  UserReview({
    this.productId,
    this.userId,
    this.rate,
    this.status,
  });

  int productId;
  int userId;
  double rate;
  DateTime completeOn;
  bool status;

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "userId": userId,
        "rate": rate,
        "status": status,
      };
}

class UserUpdateReview {
  UserUpdateReview({
    this.id,
    this.productId,
    this.userId,
    this.rate,
    this.status,
  });

  int id;
  int productId;
  int userId;
  double rate;
  DateTime completeOn;
  bool status;

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "userId": userId,
        "rate": rate,
        "status": status,
      };
}
