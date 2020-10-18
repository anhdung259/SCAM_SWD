import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/ProductResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class ProductListBloc {
  ProductRepository _productRepository = ProductRepository();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  getProduct() async {
    ProductResponse productList = await _productRepository.getProducts();
    _subject.sink.add(productList);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject.stream;
}

final productBloc = ProductListBloc();
