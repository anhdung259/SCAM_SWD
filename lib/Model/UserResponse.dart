import 'UserReview.dart';
import 'dart:convert';

class UserResponse {
  final User user;
  final String error;

  UserResponse(this.user, this.error);

  UserResponse.fromJson(String response)
      : user = User.fromJson(json.decode(response)),
        error = "";

  UserResponse.withError(String errorValue)
      : user = new User(),
        error = errorValue;
}
