import 'dart:convert';
import 'package:swd_project/Model/Review.dart';

class ReviewResponse {
  final List<Review> reviews;
  final String error;

  ReviewResponse(this.reviews, this.error);

  ReviewResponse.fromJson(String response)
      : reviews = json
            .decode(response)
            .map<Review>((item) => Review.fromJson(item))
            .toList(),
        error = "";

  ReviewResponse.withError(String errorValue)
      : reviews = List(),
        error = errorValue;
}
