import 'dart:convert';

import 'package:swd_project/Model/QuestionReview.dart';

class QuestionReviewResponse {
  final List<QuestionReview> questions;
  final String error;

  QuestionReviewResponse(this.questions, this.error);

  QuestionReviewResponse.fromJson(String response)
      : questions = json
            .decode(response)
            .map<QuestionReview>((item) => QuestionReview.fromJson(item))
            .toList(),
        error = "";

  QuestionReviewResponse.withError(String errorValue)
      : questions = List(),
        error = errorValue;
}
