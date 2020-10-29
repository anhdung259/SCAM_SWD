import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Review_Bloc.dart';
import 'package:swd_project/Model/Category_include_product.dart';
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
            padding: EdgeInsets.all(4),
            width: 160,
            height: 90,
            child: new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      product: productCategory[index].product,
                    ),
                  ),
                );
                reviewByIdBloc.dainStream();
              },
              child: new GridTile(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black54.withOpacity(0.2),
                            offset: new Offset(0.1, 2.0),
                            blurRadius: 3.8),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          productCategory[index].product.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.27,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // child: new Text(products[index].), //just for testing, will fill with image later
              ),
            ),
          );
        },
      ),
    );
  }
}
