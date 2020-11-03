import 'package:swd_project/Model/Category/CateVsProductResponse.dart';
import 'package:swd_project/Model/Category/CategoriesResponse.dart';
import 'package:swd_project/Model/Product/ProductResponse.dart';
import 'package:swd_project/Model/QuestionReview/QuestionReviewResponse.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewResponse.dart';
import 'package:swd_project/Model/User/UserResponse.dart';

import 'package:http/http.dart' as http;

class Repository {
  static String mainUrl = "https://scam2020.azurewebsites.net";
  var getProductUrl = '$mainUrl/api/Products';
  var getListQuestionUrl = '$mainUrl/api/Questions';
  var getListCateUrl = '$mainUrl/api/Categories';
  var getProductByCateUrl = '$mainUrl/api/Categories';
  var getListCateIncludeProductUrl = '$mainUrl/api/Categories/top';
  var getUser = '$mainUrl/api/Users/auth?';

  Future<UserResponse> getUserProfile(int id) async {
    final response = await http.get(getUser + "$id");
    if (response.statusCode == 200) {
      return UserResponse.fromJson(response.body);
    } else {
      throw Exception("fail to get User");
    }
  }

  // https://scam2020.azurewebsites.net/api/Users/auth?token=
  Future<UserResponse> login(String token) async {
    final response = await http.post(getUser + "token=$token");
    if (response.statusCode == 200) {
      print(response.statusCode);
      return UserResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("fail to get User");
    }
  }

  var getListReviewInProductUrl = '$mainUrl/api/Products';

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

  Future<ProductResponse> getProductByCate(
      int id, int pageCurrent, int pageSize) async {
    final response = await http.get(
      getProductByCateUrl +
          "/$id" +
          "/Products" +
          "?pageIndex=$pageCurrent" +
          "&pageSize=$pageSize",
    );

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

  // https://scam2020.azurewebsites.net/api/Products/2/reviews?pageNum=1&pageSize=1
  Future<ReviewResponse> getListReviewInProduct(
      int idProduct, int currentPage, int pageSize) async {
    final response = await http.get(getListReviewInProductUrl +
        "/$idProduct" +
        "/reviews" +
        "?pageNum=$currentPage" +
        "&pageSize=$pageSize");

    if (response.statusCode == 200) {
      return ReviewResponse.fromJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
