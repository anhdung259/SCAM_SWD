import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swd_project/Bloc/get_pricing_bloc.dart';
import 'package:swd_project/Model/Pricing/Pricing.dart';
import 'package:swd_project/Model/Pricing/PrincingResponse.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';

class SlideShowPricing extends StatefulWidget {
  final Product product;

  const SlideShowPricing({Key key, this.product}) : super(key: key);

  @override
  _SlideShowPricingState createState() => _SlideShowPricingState(product);
}

class _SlideShowPricingState extends State<SlideShowPricing> {
  Product product;

  _SlideShowPricingState(this.product);

  @override
  void initState() {
    super.initState();
    pricingBloc.restart();
    pricingBloc.getListPricing(product.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PricingResponse>(
        stream: pricingBloc.listPricing,
        builder: (context, AsyncSnapshot<PricingResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return BuildError(
                error: snapshot.data.error,
              );
            }
            return _buildPricingWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return BuildError(
              error: snapshot.error,
            );
          } else {
            return BuildLoading();
          }
        });
  }

  Widget _buildPricingWidget(PricingResponse data) {
    List<Pricing> pricing = data.pricingList;
    if (pricing.length == 0) {
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
      return Container(
        child: CarouselSlider.builder(
            itemCount: pricing.length,
            options: CarouselOptions(
              height: 500,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
            ),
            itemBuilder: (context, index) {
              return Container(
                width: 350,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      new BoxShadow(
                          color: Colors.black54.withOpacity(0.7),
                          offset: new Offset(0.2, 3.0),
                          blurRadius: 3.7),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: Text(
                        pricing[index].priceType.name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 27,
                          height: 1,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.27,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueGrey[800],
                      ),
                      height: 3,
                      width: 250,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 25),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "${pricing[index].price}đ",
                              style: TextStyle(
                                  fontSize: 30,
                                  letterSpacing: 0.27,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                              text: "/month",
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 0.27,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400))
                        ]))),
                    listFeatureInfo(pricing[index].productPriceInfos),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 200,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          color: Colors.green,
                          onPressed: () {},
                          child: Text(
                            'Chọn gói',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      );
  }

  Widget listFeatureInfo(List<ProductPriceInfo> listInfo) {
    return ListView.builder(
      itemCount: listInfo.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 71),
              child: Stack(
                children: [
                  Icon(
                    EvaIcons.checkmarkCircle2,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 27),
                    child: Text(
                      listInfo[index].inforText,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          letterSpacing: 0.27,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
