import 'dart:convert';
import 'package:swd_project/Model/Feature/feature.dart';

class FeatureResponse {
  final List<Feature> featureList;
  final String error;

  FeatureResponse(this.featureList, this.error);

  FeatureResponse.fromJson(String response)
      : featureList = json
            .decode(response)
            .map<Feature>((item) => Feature.fromJson(item))
            .toList(),
        error = "";

  FeatureResponse.withError(String errorValue)
      : featureList = List(),
        error = errorValue;
}