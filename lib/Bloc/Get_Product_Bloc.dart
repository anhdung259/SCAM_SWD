import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/ProductResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class ProductListBloc {
  Repository _productRepository = Repository();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductResponse> _proByCate =
      BehaviorSubject<ProductResponse>();

  getProduct() async {
    ProductResponse productList = await _productRepository.getProducts();
    _subject.sink.add(productList);
  }
  getListSize() async {
    List<Product> prod;
    ProductResponse productList = await _productRepository.getProducts();
    prod= productList.products;
    return prod;
  }

  getProductByCategory(int id) async {
    ProductResponse productList = await _productRepository.getProductByCate(id);
    _proByCate.sink.add(productList);
  }

  void dainStream() {
    _proByCate.value = null;
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
    _proByCate.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject.stream;
  BehaviorSubject<ProductResponse> get proCate => _proByCate.stream;
}

final productBloc = ProductListBloc();
