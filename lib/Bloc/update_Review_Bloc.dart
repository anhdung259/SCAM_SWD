import 'package:http/http.dart' as http;
import 'package:swd_project/Model/ReviewAnswer/ReviewAnswer.dart';

class UpdateReviewBloc {
  static String mainUrl =
      "https://scam2020.azurewebsites.net/api/UserReviews/user-answer";
  Future<dynamic> updateReview(AnswerUpdate post) async {
    String body = answerUpdateToJson(post);
    var response = await http.put(mainUrl, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
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
