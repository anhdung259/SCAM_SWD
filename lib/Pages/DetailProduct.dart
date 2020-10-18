import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swd_project/Components/ProductInfo.dart';
import 'package:swd_project/Components/ReviewInfo.dart';
import 'package:swd_project/Model/Product.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({Key key, this.product}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(product);
}

class _DetailPageState extends State<DetailPage> {
  final Product product;

  _DetailPageState(this.product);

  @override
  final List<String> _tabs = <String>[
    "Product Information",
    "Reviews",
    "Pricing",
    "Feature",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length, // This is the number of tabs.
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    backgroundColor: Color.fromARGB(255, 18, 32, 50),
                    expandedHeight: 220,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      title: Padding(
                        padding: const EdgeInsets.only(top: 150, bottom: 20),
                        child: Transform(
                          transform: Matrix4.translationValues(-35.0, 0.0, 0.0),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      new BoxShadow(
                                          color:
                                              Colors.black54.withOpacity(0.5),
                                          offset: new Offset(1.0, 3.0),
                                          blurRadius: 3.7),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(product.iconUrl),
                                    radius: 30,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 7, top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    RatingBarIndicator(
                                      rating: product.rating.toDouble(),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 12,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      indicatorColor: Colors.orange,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.white,
                      isScrollable: true,
                      // These are the widgets to put in each tab in the tab bar.
                      tabs: _tabs
                          .map((String name) => Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: [
                ProductInfo(
                  product: product,
                ),
                ReviewPage(product: product),
                ProductInfo(
                  product: product,
                ),
                ReviewPage(),
              ]),
        ),
      ),
    );
  }
}
