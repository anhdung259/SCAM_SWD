import 'package:swd_project/Model/QuestionReview.dart';

class Answer {
  int userReviewId;
  int questionId;
  String answer;

  Answer(this.userReviewId, this.questionId, this.answer);
}

class ReviewAnswer {
  ReviewAnswer({
    this.id,
    this.userReviewId,
    this.questionId,
    this.answer,
    this.status,
    this.question,
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
}
