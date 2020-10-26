import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/CateVsProductResponse.dart';
import 'package:swd_project/Model/Category.dart';
import 'package:swd_project/Model/CategoriesResponse.dart';
import 'package:swd_project/Model/Category_include_product.dart';
import 'package:swd_project/Repository/Repository.dart';

class CategoryListBloc {
  Repository _cateRepository = Repository();
  final BehaviorSubject<List<Category>> _listCate =
      BehaviorSubject<List<Category>>();
  final BehaviorSubject<CategoryVsProductResponse> _listCateIncludeProduct =
      BehaviorSubject<CategoryVsProductResponse>();
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

  getListCateIncludeProduct() async {
    CategoryVsProductResponse listCate =
        await _cateRepository.getListCateIncludeProduct(5);
    _listCateIncludeProduct.add(listCate);
  }

  dispose() {
    _listCate.close();
    _listCateIncludeProduct.close();
  }

  BehaviorSubject<List<Category>> get listCategory => _listCate.stream;
  BehaviorSubject<CategoryVsProductResponse> get listCategoryVsProduct =>
      _listCateIncludeProduct.stream;
}

final cateBloc = CategoryListBloc();
