import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Bloc/get_Product_Bloc.dart';
import 'package:swd_project/Components/Recommend/product_recommend.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/Product/ProductResponse.dart';

class RecommendForUser extends StatefulWidget {
  final int userId;

  const RecommendForUser({Key key, this.userId}) : super(key: key);
  @override
  _RecommendForUserState createState() => _RecommendForUserState(userId);
}

class _RecommendForUserState extends State<RecommendForUser> {
  final LocalStorage storage = LocalStorage('user');
  final int userId;

  _RecommendForUserState(this.userId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productBloc.getProductRecommend(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15),
      child: StreamBuilder<ProductResponse>(
        stream: productBloc.productRcm,
        builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildProductWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildProductWidget(ProductResponse data) {
    List<Product> products = data.products;
    if (products.length == 0) {
      return Container(
        child: Text("No Product"),
      );
    } else {
      return Container(
        height: 180,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Đề xuất cho bạn",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.27,
                  color: Colors.blueGrey[900]),
            ),
          ),
          Expanded(
            child: ListProductRecommend(
              products: products,
            ),
          ),
        ]),
      );
    }
  }
}
