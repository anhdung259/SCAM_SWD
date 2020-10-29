import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Review_Bloc.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/ReviewList.dart';
import 'package:swd_project/Model/ReviewResponse.dart';
import 'package:swd_project/Pages/DetailProduct.dart';
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
  @override
  void initState() {
    super.initState();
    reviewByIdBloc.getReview(product.id);
  }

  _ReviewPageState(this.product);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
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
                children: [],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black54.withOpacity(0.3),
                            offset: new Offset(1.0, 3.0),
                            blurRadius: 3.7),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 48,
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
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Color.fromARGB(255, 18, 32, 50),
                        ),
                      ),
                      getFilterBarUI(reviews.length.toString()),
                      ListReview(
                        reviews: reviews,
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget getFilterBarUI(String count) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: count == "0"
                        ? Text(
                            "Hiện tại chưa có bài review",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          )
                        : Text(
                            "Hiện tại có $count bài review",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => DetailPage(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                size: 26,
                                color: Color.fromARGB(255, 18, 32, 50)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}
