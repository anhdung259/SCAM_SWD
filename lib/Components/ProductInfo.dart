import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Review_Bloc.dart';
import 'package:swd_project/Model/Product.dart';

import 'ShowMore.dart';

class ProductInfo extends StatefulWidget {
  final Product product;

  const ProductInfo({Key key, this.product}) : super(key: key);
  @override
  _ProductInfoState createState() => _ProductInfoState(product);
}

class _ProductInfoState extends State<ProductInfo> {
  final Product product;
  _ProductInfoState(this.product);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewByIdBloc.getReview(product.id);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      "Product Details",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      new BoxShadow(
                          color: Colors.black54.withOpacity(0.5),
                          offset: new Offset(1.0, 3.0),
                          blurRadius: 3.7),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowMore(
                      title: "${product.name} Overview",
                      text: product.overview,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text(
                    //     "${product.name} Overview",
                    //     style: TextStyle(
                    //         fontSize: 17, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Text(
                    //     "What is ${product.name} ?",
                    //     style: TextStyle(
                    //       fontStyle: FontStyle.italic,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 5.0,
                    ),

                    ShowMore(
                      text: product.description,
                      title: "Description",
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
