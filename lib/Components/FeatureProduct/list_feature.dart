
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swd_project/Bloc/get_feature_Bloc.dart';
import 'package:swd_project/Model/Feature/FeatureResponse.dart';
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
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildFeatureBlocWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
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
        Text("Error: $error"),
      ],
    ));
  }

  Widget _buildFeatureBlocWidget(FeatureResponse data) {
    List<Feature> features = data.featureList;
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
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Feature Product",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: ListView.builder(
                  itemCount: features.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 25),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            features[index].feature.featureName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                letterSpacing: 0.27,
                                fontWeight: FontWeight.w600),
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
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
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
