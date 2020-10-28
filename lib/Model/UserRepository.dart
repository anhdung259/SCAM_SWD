import 'User.dart';
import 'dart:convert';

class UserRepository {
  final User user;
  final String error;

  UserRepository(this.user, this.error);

  UserRepository.fromJson(String response)
      : user = json.decode(response).map<User>((item) => User.fromJson(item)),
        error = "";

  UserRepository.withError(String errorValue)
      : user = User(),
        error = errorValue;
}
