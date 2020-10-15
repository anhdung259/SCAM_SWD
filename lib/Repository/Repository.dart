import 'package:dio/dio.dart';
import 'package:swd_project/Model/Product.dart';
import '../Model/ProductResponse.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductRepository {
  // final String apiKey = "Your-Api-Key";
  static String mainUrl = "https://scam2020.azurewebsites.net";

  final Dio _dio = Dio();
  var getProductUrl = '$mainUrl/api/Products';

  // var getPlayingUrl = '$mainUrl/movie/now_playing';

  Future<List<Product>> getProducts() async {
    final response = await http.get(getProductUrl);

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map<Product>((item) => Product.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}
