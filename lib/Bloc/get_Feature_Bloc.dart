import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/Feature/FeatureResponse.dart';
import 'package:swd_project/Model/Feature/feature.dart';
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

  Future<bool> checkReviewFeature(int productId) async {
    FeatureReviewResponse featureUpdateResponse =
        await _featureRepo.getFeatureUpdate(productId);
    if (featureUpdateResponse.featureList.isEmpty) {
      return true;
    }
    return false;
  }

  Future<List<FeatureReview>> listReviewFeature(int productId) async {
    FeatureReviewResponse featureUpdateResponse =
        await _featureRepo.getFeatureUpdate(productId);
    return featureUpdateResponse.featureList;
  }

  dispose() {
    _listFeature.close();
  }

  BehaviorSubject<FeatureResponse> get listFeature => _listFeature.stream;
}

final featureBloc = FeatureBloc();
