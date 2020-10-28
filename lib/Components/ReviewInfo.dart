import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Review_Bloc.dart';
import 'package:swd_project/Components/ListCheckBoxFilterStar.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/Review.dart';
import 'package:swd_project/Model/ReviewResponse.dart';
import 'package:swd_project/Pages/Review.dart';
import 'ListReview.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 15),
      child: StreamBuilder<ReviewResponse>(
        stream: reviewByIdBloc.subject,
        builder: (context, AsyncSnapshot<ReviewResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildReviewWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
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
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildReviewWidget(ReviewResponse data) {
    List<Review> reviews = data.reviews;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(left: 5, right: 10),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2),
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
                height: 10,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Filter review",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ListCheckBoxFilterStar(),
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton.icon(
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
                        icon: Icon(
                          EvaIcons.edit2,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Viết review",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color.fromARGB(255, 18, 32, 60),
                      ),
                    ),
                  ],
                ),
              ),
              ListReview(
                reviews: reviews,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
