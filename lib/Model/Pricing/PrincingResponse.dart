import 'dart:convert';
import 'package:swd_project/Model/Pricing/Pricing.dart';

class PricingResponse {
  final List<Pricing> pricingList;
  final String error;

  PricingResponse(this.pricingList, this.error);

  PricingResponse.fromJson(String response)
      : pricingList = json
            .decode(response)
            .map<Pricing>((item) => Pricing.fromJson(item))
            .toList(),
        error = "";

  PricingResponse.withError(String errorValue)
      : pricingList = List(),
        error = errorValue;
}
