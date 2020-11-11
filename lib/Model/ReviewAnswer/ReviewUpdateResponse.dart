import 'dart:convert';

import 'package:swd_project/Model/ReviewAnswer/ReviewList.dart';

class ReviewUpdateResponse {
  final Review review;
  final String error;

  ReviewUpdateResponse(this.review, this.error);

  ReviewUpdateResponse.fromJson(String response)
      : review = Review.fromJson(json.decode(response)),
        error = "";

  ReviewUpdateResponse.withError(String errorValue)
      : review = Review(),
        error = errorValue;
}
