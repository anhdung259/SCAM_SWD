import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/Industry/industry.dart';
import 'package:swd_project/Repository/Repository.dart';

class IndustryBloc {
  Repository _industryRepository = Repository();
  final BehaviorSubject<List<Industry>> _listIndustry =
      BehaviorSubject<List<Industry>>();
  Future<List<IndustryClass>> getListIndustryReview(int productId) async {
    List<IndustryClass> listIndustryFilter =
        await _industryRepository.getIndustry(productId);
    return listIndustryFilter;
  }

  void restart() {
    _listIndustry.value = null;
  }

  dispose() {
    _listIndustry.close();
  }

  BehaviorSubject<List<Industry>> get listIndustry => _listIndustry.stream;
}

final industryBloc = IndustryBloc();
