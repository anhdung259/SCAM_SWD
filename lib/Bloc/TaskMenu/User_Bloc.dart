import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/UserRepository.dart';
import 'package:swd_project/Repository/Repository.dart';

class UserBloc {
  Repository _userRepository = Repository();
  final BehaviorSubject<UserRepository> _userBehavior =
      BehaviorSubject<UserRepository>();

  getUser(int id) async {
    UserRepository user = await _userRepository.getUserProfile(id);
    _userBehavior.sink.add(user);
  }

  dispose() async {
    await _userBehavior.drain();
    _userBehavior.close();
  }

  BehaviorSubject<UserRepository> get userProfile => _userBehavior.stream;
}

final userBloc = UserBloc();
