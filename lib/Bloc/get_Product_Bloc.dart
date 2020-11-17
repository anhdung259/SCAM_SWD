import 'package:rxdart/rxdart.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/Product/ProductResponse.dart';
import 'package:swd_project/Repository/Repository.dart';

class ProductListBloc {
  Repository _productRepository = Repository();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductDetailResponse> _proDetail =
      BehaviorSubject<ProductDetailResponse>();
  final BehaviorSubject<ProductResponse> _proRmm =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<List<Product>> _proByCate =
      BehaviorSubject<List<Product>>();
  List<Product> listAll = [];

  getProduct() async {
    ProductResponse productList = await _productRepository.getProducts();
    _subject.sink.add(productList);
  }

  getProductRecommend() async {
    ProductResponse productList =
        await _productRepository.getProductRecommend();
    _proRmm.sink.add(productList);
  }

  getListSize() async {
    List<Product> prod;
    ProductResponse productList = await _productRepository.getProducts();
    prod = productList.products;
    return prod;
  }

  getProductByCategory(int id, int pageCurrent, int pageSize) async {
    ProductResponse productList =
        await _productRepository.getProductByCate(id, pageCurrent, pageSize);
    listAll.addAll(productList.products);
    _proByCate.sink.add(listAll);
  }

  getProductDetail(int productId) async {
    ProductDetailResponse proDetail =
        await _productRepository.getProductDetail(productId);
    _proDetail.sink.add(proDetail);
  }

  dainStream() {
    _proByCate.value = null;
    _proDetail.value = null;
    listAll.clear();
  }

  reset() async {
    _proRmm.value = null;
  }

  dispose() async {
    await _proRmm.drain();
    await _subject.drain();
    await _proDetail.drain();

    _subject.close();
    _proRmm.close();
    _proDetail.close();
    _proByCate.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject.stream;
  BehaviorSubject<ProductResponse> get productRcm => _proRmm.stream;
  BehaviorSubject<List<Product>> get proCate => _proByCate.stream;
  BehaviorSubject<ProductDetailResponse> get prodDetail => _proDetail.stream;
}

final productBloc = ProductListBloc();
