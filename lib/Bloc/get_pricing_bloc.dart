import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/Pricing/PrincingResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class PricingBloc {
  Repository _pricingRepository = Repository();
  final BehaviorSubject<PricingResponse> _listPricing =
      BehaviorSubject<PricingResponse>();
  getListPricing(int productId) async {
    PricingResponse listPricing =
        await _pricingRepository.getListPricing(productId);
    _listPricing.sink.add(listPricing);
  }

  void restart() {
    _listPricing.value = null;
  }

  dispose() {
    _listPricing.close();
  }

  BehaviorSubject<PricingResponse> get listPricing => _listPricing.stream;
}

final pricingBloc = PricingBloc();
