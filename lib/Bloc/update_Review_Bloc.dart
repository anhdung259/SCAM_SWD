import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewAnswer.dart';

class UpdateReviewBloc {
  final LocalStorage _storage = LocalStorage('token');
  static String mainUrl =
      "https://scam2020.azurewebsites.net/api/UserReviews/user-answer";
  Future<dynamic> updateReview(AnswerUpdate post) async {
    String body = answerUpdateToJson(post);
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
}

final updateReviewBloc = UpdateReviewBloc();
