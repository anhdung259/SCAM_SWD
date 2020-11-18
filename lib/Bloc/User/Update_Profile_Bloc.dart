import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Model/User/IndustryExpert.dart';
import 'package:swd_project/Model/User/User.dart';

class updateProfile {
  final LocalStorage _storage = LocalStorage('token');
  static String mainUrl =
      "https://scam2020.azurewebsites.net/api/Users/details";
  var updateIndustry = "https://scam2020.azurewebsites.net/api/Users/Industries";
  Future<dynamic> updateUserProfile(UserDetail user) async {
    String body = json.encode(user.toJson());
    print('_______$body');
    var response = await http.put(mainUrl, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'Authorization': 'Bearer ${_storage.getItem('token')}',
    });
    if (response.statusCode == 200) {
      print(response.body);
      return response.statusCode;
    } else {
      print(response.statusCode);
      return response.statusCode;
    }
  }
  Future<dynamic> updateUserIndustry(List<IndustryExpert> indusE) async {
    String body = industryExpertToJson(indusE);
    print('_______$body');
    var response = await http.put(updateIndustry, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'Authorization': 'Bearer ${_storage.getItem('token')}',
    });
    if (response.statusCode == 200) {
      print(response.body);
      return response.statusCode;
    } else {
      print(response.statusCode);
      return response.statusCode;
    }
  }
}

final updateUserBloc = updateProfile();
