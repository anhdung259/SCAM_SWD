import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/CateVsProductResponse.dart';
import 'package:swd_project/Model/Category.dart';
import 'package:swd_project/Model/CategoriesResponse.dart';
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
    _listCate.sink.add(listCateAll);
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
