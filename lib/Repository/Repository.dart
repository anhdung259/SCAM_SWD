import 'package:swd_project/Model/QuestionReviewResponse.dart';

import '../Model/ProductResponse.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  static String mainUrl = "https://scam2020.azurewebsites.net";
  var getProductUrl = '$mainUrl/api/Products';
  var getListQuestionUrl = '$mainUrl/api/Questions';

  Future<ProductResponse> getProducts() async {
    final response = await http.get(getProductUrl);

    if (response.statusCode == 200) {
      print("bbbb");
      return ProductResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<QuestionReviewResponse> getListQuestion() async {
    final response = await http.get(getListQuestionUrl);

    if (response.statusCode == 200) {
      print("aaaaaaaaaaaa");
      return QuestionReviewResponse.fromJson(response.body);
    } else {
      print("aaaaaaaaaaaa");
      throw Exception('Failed to load post');
    }
  }
}
