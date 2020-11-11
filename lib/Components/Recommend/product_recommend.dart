import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swd_project/Bloc/get_Review_Bloc.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Pages/detail_product.dart';

class ListProductRecommend extends StatefulWidget {
  final List<Product> products;

  const ListProductRecommend({Key key, this.products}) : super(key: key);
  @override
  _ListProductRecommendState createState() =>
      _ListProductRecommendState(products);
}

class _ListProductRecommendState extends State<ListProductRecommend> {
  final List<Product> products;
  _ListProductRecommendState(this.products);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.take(5).length,
        physics: ScrollPhysics(),
        // ngao ngao ko scroll này
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(4),
            width: 250,
            height: 100,
            child: new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      product: products[index],
                    ),
                  ),
                );
                reviewByIdBloc.dainStream();
              },
              child: new GridTile(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black54.withOpacity(0.2),
                            offset: new Offset(0.1, 2.0),
                            blurRadius: 3.8),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          width: 96,
                          height: 90,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(products[index].iconUrl),
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                      RatingBarIndicator(
                        rating: products[index].rating.toDouble(),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 17,
                        direction: Axis.horizontal,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          products[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.27,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // child: new Text(products[index].), //just for testing, will fill with image later
              ),
            ),
          );
        },
      ),
    );
  }
}
