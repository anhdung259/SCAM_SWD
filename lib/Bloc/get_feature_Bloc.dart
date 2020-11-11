import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/Feature/FeatureResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class FeatureBloc {
  Repository _featureRepo = Repository();
  final BehaviorSubject<FeatureResponse> _listFeature =
      BehaviorSubject<FeatureResponse>();
  getListFeature(int productId) async {
    FeatureResponse listFeature = await _featureRepo.getFeature(productId);
    _listFeature.sink.add(listFeature);
  }

  void restart() {
    _listFeature.value = null;
  }

  dispose() {
    _listFeature.close();
  }

  BehaviorSubject<FeatureResponse> get listFeature => _listFeature.stream;
}

final featureBloc = FeatureBloc();
