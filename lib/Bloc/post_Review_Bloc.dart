import 'package:http/http.dart' as http;
import 'package:swd_project/Model/ReviewAnswer/ReviewAnswer.dart';

class PostReviewBloc {
  static String mainUrl =
      "https://scam2020.azurewebsites.net/api/UserReviews/user-answer";
  Future<dynamic> postReview(AnswerPost post) async {
    String body = answerPostToJson(post);
    var response = await http.post(mainUrl, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
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
