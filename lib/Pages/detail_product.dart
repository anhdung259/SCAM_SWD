import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swd_project/Components/DetailProduct/product_info.dart';
import 'package:swd_project/Components/Pricing/Pricing_show.dart';
import 'package:swd_project/Components/ReviewProduct/review_info.dart';
import 'package:swd_project/Model/Product/Product.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final int page;
  final bool checkFilter;
  const DetailPage({Key key, this.product, this.page, this.checkFilter})
      : super(key: key);

  @override
  _DetailPageState createState() =>
      _DetailPageState(product, page, checkFilter);
}

class _DetailPageState extends State<DetailPage> {
  final Product product;
  final int page;
  final bool checkFilter;
  _DetailPageState(this.product, this.page, this.checkFilter);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  final List<String> _tabs = <String>[
    "Thông tin",
    "Đánh giá",
    "Giá",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: page == null ? 0 : page,
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
                        child: SingleChildScrollView(
                          child: Transform(
                            transform:
                                Matrix4.translationValues(-35.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
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
                                      backgroundColor: Colors.white,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                ReviewPage(
                  product: product,
                  currentPage: 1,
                  pageSize: 3,
                  checkFilter: checkFilter ?? true,
                ),
                SlideShowPricing(
                  product: product,
                )
              ]),
        ),
      ),
    );
  }
}
