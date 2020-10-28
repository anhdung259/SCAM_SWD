import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:swd_project/Bloc/Get_Product_Bloc.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/ProductResponse.dart';
import 'package:swd_project/Pages/DetailProduct.dart';

class SlideShow2 extends StatefulWidget {
  @override
  _SlideShow2State createState() => _SlideShow2State();
}

class _SlideShow2State extends State<SlideShow2> {
  @override
  void initState() {
    super.initState();
    productBloc.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
        stream: productBloc.subject,
        builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildHomeWidget(snapshot.data);
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
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
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(ProductResponse data) {
    final double height = MediaQuery.of(context).size.height;
    List<Product> product = data.products;
    if (product.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 230.0,
        child: PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            length: product.take(5).length,
            indicatorSpace: 8.0,
            padding: const EdgeInsets.all(5.0),
            shape: IndicatorShape.circle(size: 5.0),
            child: CarouselSlider.builder(
              itemCount: product.take(5).length,
              options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  autoPlayAnimationDuration:
                      const Duration(milliseconds: 3000)),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(product: product[index]),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: product[index].id,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 230.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      product[index].backgroundImageUrl)),
                            )),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(),
                      ),
                      Positioned(
                          bottom: 30.0,
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: 250.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  product[index].name,
                                  style: TextStyle(
                                      height: 1.5,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                );
              },
            )),
      );
  }
}
