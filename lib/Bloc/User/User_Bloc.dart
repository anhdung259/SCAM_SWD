import 'package:localstorage/localstorage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/User/IndustryExpert.dart';
import 'package:swd_project/Model/User/UserResponse.dart';
import 'package:swd_project/Model/Industry/industry.dart';

import 'package:swd_project/Repository/Repository.dart';

class UserBloc {
  Repository _userRepository = Repository();
  final BehaviorSubject<UserResponse> _userBehavior =
      BehaviorSubject<UserResponse>();
  final BehaviorSubject<List<IndustryExpert>> _userIndustryBehavior =
      BehaviorSubject<List<IndustryExpert>>();
  final BehaviorSubject<List<IndustryClass>> _industryBehavior =
      BehaviorSubject<List<IndustryClass>>();


  // final LocalStorage storage = new LocalStorage('user');
  final LocalStorage storageToken = new LocalStorage('token');
  final LocalStorage storageUser = new LocalStorage('user');

  getAllIndustry() async{
    List<IndustryClass> _listIndustry = await _userRepository.getAllIndustry();
    _industryBehavior.sink.add(_listIndustry);
  }
  getIndustryOfUser() async{
    List<IndustryExpert> listIndustry = await _userRepository.getListIndustryExpert();
    _userIndustryBehavior.sink.add(listIndustry);
  }
  getUser() async {
    String token = await storageToken.getItem("token");
    print("_________$token");
    UserResponse user = await _userRepository.getProfileUser(token);
    _userBehavior.sink.add(user);
  }

  getUserLogin(String token) async {
    String tokenUser = await _userRepository.login(token);
    await storageToken.setItem('token', tokenUser);
    UserResponse userProfile = await _userRepository.getProfileUser(tokenUser);
    await storageUser.setItem('user', userProfile.user.toJson());
  }

  dispose() async {
    _userBehavior.close();
    _userIndustryBehavior.close();
    _industryBehavior.close();
  }

  BehaviorSubject<UserResponse> get userProfile => _userBehavior.stream;
  BehaviorSubject<List<IndustryExpert>> get userIndustry => _userIndustryBehavior.stream;
  BehaviorSubject<List<IndustryClass>> get allIndustry => _industryBehavior.stream;
}

final userBloc = UserBloc();
