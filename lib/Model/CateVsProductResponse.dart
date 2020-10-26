import 'dart:convert';

import 'package:swd_project/Model/Category.dart';
import 'package:swd_project/Model/Category_include_product.dart';

class CategoryVsProductResponse {
  final List<CategoryWithProduct> categories;
  final String error;

  CategoryVsProductResponse(this.categories, this.error);

  CategoryVsProductResponse.fromJson(String response)
      : categories = json
            .decode(response)
            .map<CategoryWithProduct>(
                (item) => CategoryWithProduct.fromJson(item))
            .toList(),
        error = "";

  CategoryVsProductResponse.withError(String errorValue)
      : categories = List(),
        error = errorValue;
}
