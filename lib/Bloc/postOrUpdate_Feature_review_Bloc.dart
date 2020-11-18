import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Model/Feature/feature.dart';

class PostFeatureReviewBloc {
  final LocalStorage _storage = LocalStorage('token');
  static String mainUrl =
      "https://scam2020.azurewebsites.net/api/Products/Features/reviews";

  Future<dynamic> postFeatureReview(List<FeatureReview> post) async {
    String body = featureReviewToJson(post);
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

  Future<dynamic> updateFeatureReview(List<FeatureReview> post) async {
    String body = featureReviewToJson(post);
    print(body);
    var response = await http.put(mainUrl, body: body, headers: {
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

final postFeatureReviewBloc = PostFeatureReviewBloc();
