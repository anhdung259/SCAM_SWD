import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Model/Category/CateVsProductResponse.dart';
import 'package:swd_project/Model/Category/CategoriesResponse.dart';
import 'package:swd_project/Model/Feature/FeatureResponse.dart';
import 'package:swd_project/Model/Industry/industry.dart';
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
  var getToken = '$mainUrl/api/Users/Authenticate?';
  var getUser = '$mainUrl/api/Users/profile?';
  var getReviewUser = '$mainUrl/api/UserReviews';
  var getPricingList = '$mainUrl/api/Products';
  final LocalStorage _storage = LocalStorage('token');
  var getRecommend = '$mainUrl/api/Products/Recommendations';

  // https://scam2020.azurewebsites.net/api/Users/auth?token=
  Future<String> login(String token) async {
    final response = await http.post(getToken + "idtoken=$token");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      throw Exception("fail to get User");
    }
  }

  Future<UserResponse> getProfileUser(String token) async {
    final response = await http.post(getUser + "token=$token", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_storage.getItem('token')}',
    });
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

  Future<ProductDetailResponse> getProductDetail(int productId) async {
    final response = await http.get(getProductUrl + "/$productId/details");

    if (response.statusCode == 200) {
      return ProductDetailResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ProductResponse> getProductRecommend() async {
    String token = await _storage.getItem('token');
    print(token);
    final response = await http.get(getRecommend, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_storage.getItem('token')}',
    });

    if (response.statusCode == 200) {
      print(response.statusCode);
      return ProductResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
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
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_storage.getItem('token')}',
        });

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(response.body);
    } else {
      print(_storage.getItem('token'));
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
  Future<ReviewUpdateResponse> getReviewUserUpdate(int productId) async {
    final response = await http
        .get(getReviewUser + "/$productId" + "/user-answer", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_storage.getItem('token')}',
    });

    if (response.statusCode == 200) {
      return ReviewUpdateResponse.fromJson(response.body);
    } else {
      return ReviewUpdateResponse.withError(response.statusCode.toString());
    }
  }

  // https://scam2020.azurewebsites.net/api/Products/40/Reviews/filter?industryID=1&rates=5&pageNum=1&pageSize=10
  Future<ReviewResponse> getListReviewFilter(
      int idProduct, int currentPage, int pageSize, String filter) async {
    final response = await http.get(getListReviewInProductUrl +
        "/$idProduct" +
        "/Reviews" +
        "/filters?" +
        filter +
        "pageNum=$currentPage" +
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
        "&pageSize=100000000");

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

//https://scam2020.azurewebsites.net/api/UserReviews/40/Reviews/industries
  Future<List<IndustryClass>> getIndustry(int productId) async {
    final response =
        await http.get(getReviewUser + "/$productId" + "/Reviews/industries");

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map<IndustryClass>((item) => IndustryClass.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load ');
    }
  }
}
