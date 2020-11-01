import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/get_Categories_Bloc.dart';
import 'package:swd_project/Model/Category/CateVsProductResponse.dart';
import 'package:swd_project/Model/Category/Category_include_product.dart';

import 'category_include_product.dart';

class CategoryListIncludeProduct extends StatefulWidget {
  @override
  _CategoryListIncludeProductState createState() =>
      _CategoryListIncludeProductState();
}

class _CategoryListIncludeProductState
    extends State<CategoryListIncludeProduct> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cateBloc.getListCateIncludeProduct();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   cateBloc.getListCateIncludeProduct();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15),
      child: StreamBuilder<CategoryVsProductResponse>(
        stream: cateBloc.listCategoryVsProduct,
        builder: (context, AsyncSnapshot<CategoryVsProductResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildCategoryWidget(snapshot.data);
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

  Widget _buildCategoryWidget(CategoryVsProductResponse data) {
    List<CategoryWithProduct> cate = data.categories
        .where((cate) => cate.categoryId.toString() == "null")
        .toList();
    if (cate.length == 0) {
      return Container(
        child: Text("No Category"),
      );
    } else {
      return CategoryListProduct(categories: cate);
    }
  }
}
