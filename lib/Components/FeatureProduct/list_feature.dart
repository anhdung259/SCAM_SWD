import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swd_project/Model/Feature/feature.dart';
import 'package:swd_project/Model/Product/Product.dart';

class FeatureList extends StatefulWidget {
  final Product product;

  const FeatureList({Key key, this.product}) : super(key: key);

  @override
  _FeatureListState createState() => _FeatureListState(product);
}

class _FeatureListState extends State<FeatureList> {
  Product product;
  List<ProductFeature> features = [];
  List<FeatureReview> listFeatureReview = [];

  _FeatureListState(this.product);

  Map<int, String> answer = {};

  @override
  void initState() {
    super.initState();
    features = product.productFeatures;
  }

  @override
  Widget build(BuildContext context) {
    if (features.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Chưa có dữ liệu ",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                new BoxShadow(
                    color: Colors.black54.withOpacity(0.5),
                    offset: new Offset(0.2, 3.0),
                    blurRadius: 3.7),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Tính năng sản phẩm",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: ListView.builder(
                  itemCount: features.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8, left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  features[index].feature.featureName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      letterSpacing: 0.27,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 210,
                                animation: true,
                                lineHeight: 21.0,
                                animationDuration: 1000,
                                percent: features[index].rate / 100,
                                center: new Text(
                                  "${features[index].rate.toStringAsFixed(2)}%",
                                  style: TextStyle(color: Colors.white),
                                ),
                                animateFromLastPercent: true,
                                progressColor: Colors.blueGrey[500],
                                // maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 140),
                          child: Text(
                            "(Dựa trên ${features[index].rateCount} đánh giá)",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}
