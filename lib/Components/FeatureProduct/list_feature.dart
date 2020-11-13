import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swd_project/Bloc/get_feature_Bloc.dart';
import 'package:swd_project/Model/Feature/FeatureResponse.dart';
import 'package:swd_project/Model/Feature/feature.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';

class FeatureList extends StatefulWidget {
  final Product product;

  const FeatureList({Key key, this.product}) : super(key: key);

  @override
  _FeatureListState createState() => _FeatureListState(product);
}

class _FeatureListState extends State<FeatureList> {
  Product product;
  List<Feature> features = [];
  _FeatureListState(this.product);

  @override
  void initState() {
    super.initState();
    featureBloc.restart();
    featureBloc.getListFeature(product.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FeatureResponse>(
        stream: featureBloc.listFeature,
        builder: (context, AsyncSnapshot<FeatureResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return BuildError(
                error: snapshot.data.error,
              );
            }
            features = snapshot.data.featureList;
            return _buildFeatureWidget();
          } else if (snapshot.hasError) {
            return BuildError(
              error: snapshot.error,
            );
          } else {
            return BuildLoading();
          }
        });
  }

  Widget _buildFeatureWidget() {
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
                  RaisedButton.icon(
                    // Đã review rồi thì chỉ được update
                    label: Text("Đánh giá tính năng"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return dialogUpdateReview(
                                context, product, "Đánh giá tính năng");
                          });
                    },
                    icon: Icon(
                      EvaIcons.edit,
                      color: Colors.white,
                    ),
                  )
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
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  "${features[index].rate}%",
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

  Widget updateFeature() {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ListView.builder(
                itemCount: features.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Container(
                          child: RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              // answer.update(qr.id, (v) => rating.toString(),
                              //     ifAbsent: () => rating.toString());
                              // setState(() {
                              //   rate = rating;
                              // });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
  }

  Widget dialogUpdateReview(
      BuildContext context, Product product, String title) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 90),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Text('$title ${product.name}')),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  if (await confirm(
                    context,
                    title: Text('Xác nhận'),
                    content: Text('Bạn muốn dừng cập nhật tính năng ?'),
                    textOK: Text('Có'),
                    textCancel: Text('Không'),
                  )) {
                    return Navigator.of(context).pop();
                  }
                  return null;
                })
          ]),
      content: Container(width: double.maxFinite, child: updateFeature()),
    );
  }
}
