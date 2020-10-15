import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/ProductResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class ProductListBloc {
  ProductRepository _productRepository = ProductRepository();
  final BehaviorSubject<List<Product>> _subject =
      BehaviorSubject<List<Product>>();

  getProduct() async {
    List<Product> productList = await _productRepository.getProducts();
    _subject.sink.add(productList);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Product>> get subject => _subject.stream;
}

final productBloc = ProductListBloc();
