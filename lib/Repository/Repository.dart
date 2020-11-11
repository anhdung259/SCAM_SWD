import 'dart:convert';

import 'package:swd_project/Model/Category/CateVsProductResponse.dart';
import 'package:swd_project/Model/Category/CategoriesResponse.dart';
import 'package:swd_project/Model/Feature/FeatureResponse.dart';
import 'package:swd_project/Model/Pricing/PrincingResponse.dart';
import 'package:swd_project/Model/Product/ProductResponse.dart';
import 'package:swd_project/Model/QuestionReview/QuestionReviewResponse.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewResponse.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewUpdateResponse.dart';
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
  var getReviewUser = '$mainUrl/api/UserReviews';
  var getPricingList = '$mainUrl/api/Products';

  Future<UserResponse> getUserProfile(int id) async {
    final response = await http.get(getUser + "$id");
    if (response.statusCode == 200) {
      print(json.decode(response.body));
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

  Future<ProductResponse> getProductRecommend(int userId) async {
    final response =
        await http.get(getProductUrl + "/Recommend?userID=$userId");

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

  //get review to update
  //https://scam2020.azurewebsites.net/api/UserReviews/282/user-answer
  Future<ReviewUpdateResponse> getReviewUserUpdate(int reviewId) async {
    final response =
        await http.get(getReviewUser + "/$reviewId" + "/user-answer");

    if (response.statusCode == 200) {
      return ReviewUpdateResponse.fromJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

//https://scam2020.azurewebsites.net/api/Products/40/reviews/rates?rates=1&rates=2&rates=0&rates=0&rates=0&pageNum=1&pageSize=3
  Future<ReviewResponse> getListReviewFilter(
      int idProduct,
      int currentPage,
      int pageSize,
      int rate1,
      int rate2,
      int rate3,
      int rate4,
      int rate5) async {
    if (rate1 == null) rate1 = 0;
    if (rate2 == null) rate2 = 0;
    if (rate3 == null) rate3 = 0;
    if (rate4 == null) rate4 = 0;
    if (rate5 == null) rate5 = 0;
    final response = await http.get(getListReviewInProductUrl +
        "/$idProduct" +
        "/reviews" +
        "/rates?rates=$rate1" +
        "&rates=$rate2" +
        "&rates=$rate3" +
        "&rates=$rate4" +
        "&rates=$rate5"
            "&pageNum=$currentPage" +
        "&pageSize=$pageSize");

    if (response.statusCode == 200) {
      return ReviewResponse.fromJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<ReviewResponse> getListReview(int idProduct) async {
    final response = await http.get(getListReviewInProductUrl +
        "/$idProduct" +
        "/reviews" +
        "?pageNum=1" +
        "&pageSize=1000");

    if (response.statusCode == 200) {
      return ReviewResponse.fromJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

//https://scam2020.azurewebsites.net/api/Products/40/Prices
  Future<PricingResponse> getListPricing(int productId) async {
    final response = await http.get(getPricingList + "/$productId" + "/Prices");

    if (response.statusCode == 200) {
      return PricingResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load review');
    }
  }

  //https://scam2020.azurewebsites.net/api/Products/40/Features
  Future<FeatureResponse> getFeature(int productId) async {
    final response =
        await http.get(getProductUrl + "/$productId" + "/Features");

    if (response.statusCode == 200) {
      return FeatureResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load feature');
    }
  }
}
