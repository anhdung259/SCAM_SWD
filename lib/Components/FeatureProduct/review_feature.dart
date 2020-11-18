import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:localstorage/localstorage.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:swd_project/Bloc/postOrUpdate_Feature_review_Bloc.dart';
import 'package:swd_project/Model/Feature/feature.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Pages/detail_product.dart';
import 'package:sweetalert/sweetalert.dart';

class ReviewFeature extends StatefulWidget {
  final Product product;

  const ReviewFeature({Key key, this.product}) : super(key: key);

  @override
  _ReviewFeatureState createState() => _ReviewFeatureState(product);
}

class _ReviewFeatureState extends State<ReviewFeature> {
  Product product;
  List<ProductFeature> features = [];
  List<FeatureReview> listFeatureReview = [];

  _ReviewFeatureState(this.product);

  Map<int, String> answer = {};

  @override
  void initState() {
    super.initState();
    features = product.productFeatures;
  }

  @override
  Widget build(BuildContext context) {
    return updateFeature();
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
          mainAxisSize: MainAxisSize.min,
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
                            child: SmoothStarRating(
                          rating: 0,
                          isReadOnly: false,
                          size: 50,
                          color: Colors.yellow,
                          borderColor: Colors.grey,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          defaultIconData: Icons.star_border,
                          starCount: 5,
                          allowHalfRating: true,
                          spacing: 2.0,
                          onRated: (value) {
                            answer.update(features[index].feature.id,
                                (v) => value.toString(),
                                ifAbsent: () => value.toString());
                          },
                        )),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              width: 400,
              height: 50,
              child: RaisedButton.icon(
                onPressed: () async {
                  getDataReview();
                  showProgress(context);
                },
                label: Text(
                  "Đánh giá tính năng",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                icon: Icon(
                  EvaIcons.arrowCircleUp,
                  color: Colors.white,
                ),
                color: Color.fromARGB(255, 18, 32, 50),
              ),
            )
          ],
        ),
      );
  }

  getDataReview() {
    listFeatureReview = answer.entries
        .map(
          (entry) => FeatureReview(
            featureId: entry.key,
            id: 0,
            productId: product.id,
            rate: entry.value,
          ),
        )
        .toList();
  }

  Future getFuture() {
    return Future(() async {
      await postFeatureReviewBloc.postFeatureReview(listFeatureReview);
      return 'Đánh giá thành công';
    });
  }

  Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
        context: context,
        child: FutureProgressDialog(getFuture(), message: Text('Loading...')));
    showResultDialog(context, result);
  }

  void showResultDialog(BuildContext context, String result) {
    SweetAlert.show(context, title: result, style: SweetAlertStyle.success,
        onPress: (bool isConfirm) {
      if (isConfirm) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
              builder: (context) => new DetailPage(
                page: 0,
                product: product,
              ),
            ),
            (Route<dynamic> route) => route.isFirst);
      }
      return false;
    });
  }
}
