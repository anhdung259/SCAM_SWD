import 'package:flutter/material.dart';
import 'package:swd_project/Components/DetailProduct/media_list.dart';
import 'package:swd_project/Components/FeatureProduct/list_feature.dart';
import 'package:swd_project/Model/Product/Product.dart';

import 'show_more.dart';

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
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   reviewByIdBloc.getReview(product.id);
  // }

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
              SizedBox(
                height: 10,
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
                    MediaList(
                      media: product.productMedia,
                    ),
                    ShowMore(
                      title: "${product.name} Overview",
                      text: product.overview,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    if (!product.description.isEmpty)
                      ShowMore(
                        text: product.description,
                        title: "Description",
                      )
                    else
                      Container(),
                    FeatureList(product: product)
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
