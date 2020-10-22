import 'dart:convert';

import 'package:swd_project/Model/Category.dart';

class CategoryResponse {
  final List<Category> categories;
  final String error;

  CategoryResponse(this.categories, this.error);

  CategoryResponse.fromJson(String response)
      : categories = json
            .decode(response)
            .map<Category>((item) => Category.fromJson(item))
            .toList(),
        error = "";

  CategoryResponse.withError(String errorValue)
      : categories = List(),
        error = errorValue;
}
