import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/UserResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class UserBloc {
  Repository _userRepository = Repository();
  final BehaviorSubject<UserResponse> _userBehavior =
      BehaviorSubject<UserResponse>();

  getUser(int id) async {
    UserResponse user = await _userRepository.getUserProfile(id);
    _userBehavior.sink.add(user);
  }

  dispose() async {
    _userBehavior.close();
  }

  BehaviorSubject<UserResponse> get userProfile => _userBehavior.stream;
}

final userBloc = UserBloc();
