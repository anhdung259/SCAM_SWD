import 'package:flutter/material.dart';
import 'package:swd_project/Components/ListCheckBoxFilterStar.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Pages/Review.dart';

class ReviewPage extends StatefulWidget {
  final Product product;

  const ReviewPage({Key key, this.product}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState(product);
}

class _ReviewPageState extends State<ReviewPage> {
  final Product product;

  _ReviewPageState(this.product);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      "${product.name} Reviews",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      new BoxShadow(
                          color: Colors.black54.withOpacity(0.5),
                          offset: new Offset(1.0, 3.0),
                          blurRadius: 3.7),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Filter review",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListCheckBoxFilterStar(),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionReviewPage(
                              product: product,
                            ),
                          ),
                        );
                      },
                      child: Text("Viết review"),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
