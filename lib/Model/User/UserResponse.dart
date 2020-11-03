import 'UserReview.dart';
import 'dart:convert';

class UserResponse {
  final User user;
  final String error;

  UserResponse(this.user, this.error);

  UserResponse.fromJson(String response)
      : user = User.fromJsonProfile(json.decode(response)),
        error = "";

  UserResponse.withError(String errorValue)
      : user = User(),
        error = errorValue;
}
