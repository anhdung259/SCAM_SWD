import 'package:swd_project/Model/CateVsProductResponse.dart';
import 'package:swd_project/Model/CategoriesResponse.dart';
import 'package:swd_project/Model/Category_include_product.dart';
import 'package:swd_project/Model/QuestionReviewResponse.dart';

import '../Model/ProductResponse.dart';
import 'package:http/http.dart' as http;

class Repository {
  static String mainUrl = "https://scam2020.azurewebsites.net";
  var getProductUrl = '$mainUrl/api/Products';
  var getListQuestionUrl = '$mainUrl/api/Questions';
  var getListCateUrl = '$mainUrl/api/Categories';
  var getProductByCateUrl = '$mainUrl/api/Categories';
  var getListCateIncludeProductUrl = '$mainUrl/api/Categories/top';

  Future<ProductResponse> getProducts() async {
    final response = await http.get(getProductUrl);

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<QuestionReviewResponse> getListQuestion() async {
    final response = await http.get(getListQuestionUrl);

    if (response.statusCode == 200) {
      return QuestionReviewResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<CategoryResponse> getListCate() async {
    final response = await http.get(getListCateUrl);

    if (response.statusCode == 200) {
      return CategoryResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ProductResponse> getProductByCate(int id) async {
    final response = await http.get(getProductByCateUrl + "/$id" + "/Products");

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<CategoryVsProductResponse> getListCateIncludeProduct(int size) async {
    final response =
        await http.get(getListCateIncludeProductUrl + "/$size" + "/Products");

    if (response.statusCode == 200) {
      return CategoryVsProductResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
