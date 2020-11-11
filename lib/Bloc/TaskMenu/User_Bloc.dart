import 'package:localstorage/localstorage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/User/UserResponse.dart';

import 'package:swd_project/Repository/Repository.dart';

class UserBloc {
  Repository _userRepository = Repository();
  final BehaviorSubject<UserResponse> _userBehavior =
      BehaviorSubject<UserResponse>();
  final LocalStorage storage = new LocalStorage('user');
  getUser(int id) async {
    UserResponse user = await _userRepository.getUserProfile(id);
    _userBehavior.sink.add(user);
  }

  getUserLogin(String token) async {
    UserResponse userLogin = await _userRepository.login(token);
    await storage.setItem('user', userLogin.user.toJson());
    print(userLogin.user.toJson());
  }

  dispose() async {
    _userBehavior.close();
  }

  BehaviorSubject<UserResponse> get userProfile => _userBehavior.stream;
}

final userBloc = UserBloc();
