import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewAnswer.dart';

class PostReviewBloc {
  final LocalStorage _storage = LocalStorage('token');
  static String mainUrl =
      "https://scam2020.azurewebsites.net/api/UserReviews/user-answer";
  Future<dynamic> postReview(AnswerPost post) async {
    String body = answerPostToJson(post);
    print(body);
    var response = await http.post(mainUrl, body: body, headers: {
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
}

final postReviewBloc = PostReviewBloc();
