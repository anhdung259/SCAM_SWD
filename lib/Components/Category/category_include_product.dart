import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Bloc/get_Product_Bloc.dart';
import 'package:swd_project/Components/ListProduct/list_product.dart';
import 'package:swd_project/Components/ListProduct/product_by_cate.dart';
import 'package:swd_project/Model/Category/Category_include_product.dart';

class CategoryListProduct extends StatefulWidget {
  final List<CategoryWithProduct> categories;

  CategoryListProduct({Key key, @required this.categories}) : super(key: key);

  @override
  _CategoryListProductState createState() =>
      _CategoryListProductState(categories);
}

class _CategoryListProductState extends State<CategoryListProduct>
    with SingleTickerProviderStateMixin {
  final List<CategoryWithProduct> categories;
  final LocalStorage store = LocalStorage('user');
  _CategoryListProductState(this.categories);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (categories.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "list app empty",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: categories.take(5).length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                height: 180,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            categories[index].name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.27,
                                color: Colors.blueGrey[800]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductByCate(
                                  categoryId: categories[index].id,
                                  nameCategory: categories[index].name,
                                  pageSize: 6,
                                  currentPage: 1,
                                ),
                              ),
                            );
                            productBloc.dainStream();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "Xem tất cả",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey[800]),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListProduct(
                        productCategory: categories[index].productCategories,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
