import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class PostInterest {
  final LocalStorage _storage = LocalStorage('token');
  static String mainUrl =
      "https://scam2020.azurewebsites.net/api/UserInterest/";

  Future<dynamic> postInterestProduct(int productId) async {
    var response = await http.post(mainUrl + "$productId", headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'Authorization': 'Bearer ${_storage.getItem('token')}',
    });

    if (response.statusCode == 200) {
      print(response.statusCode);
      return response.statusCode;
    } else {
      print(response.statusCode);
      return response.statusCode;
    }
  }

  Future<bool> checkInterest(int productId) async {
    final response = await http.get(mainUrl + "$productId/interest", headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'Authorization': 'Bearer ${_storage.getItem('token')}',
    });

    if (response.statusCode == 200) {
      if (response.body.contains("True")) {
        return true;
      } else {
        return false;

      }
    }
    return false;
  }
}

//https://scam2020.azurewebsites.net/api/UserInterest/40/interest

final postInterest = PostInterest();
