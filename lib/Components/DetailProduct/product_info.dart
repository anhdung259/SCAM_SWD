import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Components/DetailProduct/media_list.dart';
import 'package:swd_project/Components/FeatureProduct/list_feature.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:url_launcher/url_launcher.dart';
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
                          offset: new Offset(0.2, 3.0),
                          blurRadius: 3.2),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    product.productMedia.isEmpty
                        ? Container()
                        : MediaList(
                            media: product.productMedia,
                          ),
                    ShowMore(
                      title: "Giới thiệu ${product.name}",
                      text: product.overview,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    product.description.isEmpty
                        ? Container()
                        : ShowMore(
                            text: product.description,
                            title: "Description",
                          ),
                    companyInfo(product),
                    FeatureList(product: product),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget companyInfo(Product product) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black54.withOpacity(0.2),
                  offset: new Offset(0.1, 1.0),
                  blurRadius: 3.1),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "Nhà phát hành",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'Trang web: ',
                          style:
                              new TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        new TextSpan(
                          text: "${product.company.url}",
                          style: new TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch("${product.company.url}");
                            },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Năm thành lập: " + "${product.company.yearFounded}",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
