import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Product_Bloc.dart';
import 'package:swd_project/Model/Category_include_product.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/ProductResponse.dart';
import 'package:swd_project/Pages/DetailProduct.dart';

class ListProduct extends StatefulWidget {
  final List<ProductCategory> productCategory;

  const ListProduct({Key key, this.productCategory}) : super(key: key);
  @override
  _ListProductState createState() => _ListProductState(productCategory);
}

class _ListProductState extends State<ListProduct> {
  final List<ProductCategory> productCategory;

  _ListProductState(this.productCategory);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: productCategory.length,
        physics: ScrollPhysics(),
        // ngao ngao ko scroll này
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 160,
            height: 90,
            child: new Card(
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        product: productCategory[index].product,
                      ),
                    ),
                  );
                },
                child: new GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 0),
                          child: Container(
                            width: 97,
                            height: 93,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(
                                  productCategory[index].product.iconUrl),
                              fit: BoxFit.fill,
                            )),
                            // backgroundImage:
                            //     NetworkImage(products[index].iconUrl),
                            // radius: 56,
                          ),
                        ),
                        Text(
                          productCategory[index].product.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // child: new Text(products[index].), //just for testing, will fill with image later
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
