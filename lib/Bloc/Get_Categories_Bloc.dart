import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/Category.dart';
import 'package:swd_project/Model/CategoriesResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class CategoryListBloc {
  Repository _cateRepository = Repository();
  final BehaviorSubject<List<Category>> _listCate =
      BehaviorSubject<List<Category>>();

  getListCate() async {
    CategoryResponse listCateResponse = await _cateRepository.getListCate();
    List<Category> listCateAll = listCateResponse.categories;
    List<Category> listMain = List<Category>();
    for (int i = 0; i < listCateAll.length; i++) {
      if (listCateAll[i].categoryId == null) {
        listMain.add(listCateAll[i]);
      }
    }
    _listCate.sink.add(listMain);
  }

  dispose() {
    _listCate.close();
  }

  BehaviorSubject<List<Category>> get listCategory => _listCate.stream;
}

final cateBloc = CategoryListBloc();
