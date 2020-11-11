import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swd_project/Bloc/get_Review_Bloc.dart';
import 'package:swd_project/Components/ReviewProduct/filter_star.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewAnswer.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewList.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Pages/detail_product.dart';
import 'package:swd_project/Pages/review.dart';
import 'package:swd_project/Pages/update_review.dart';

class ReviewPage extends StatefulWidget {
  final Product product;
  final int pageSize;
  final int currentPage;
  final bool checkFilter;
  const ReviewPage(
      {Key key,
      this.product,
      this.pageSize,
      this.currentPage,
      this.checkFilter})
      : super(key: key);

  @override
  _ReviewPageState createState() =>
      _ReviewPageState(product, pageSize, currentPage, checkFilter);
}

class _ReviewPageState extends State<ReviewPage> {
  final LocalStorage storage = LocalStorage('user');
  User user;
  final Product product;
  final bool checkFilter;
  int count;
  int pageSize;
  int currentPage;

  _ReviewPageState(
      this.product, this.pageSize, this.currentPage, this.checkFilter);

  List<String> listIdQuestion = ["7", "8", "9", "10"];
  List<Review> listAllReview = [];
  List<Review> reviews;
  int reviewId;
  bool checkReview = false;
  RefreshController _controller1 = RefreshController();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    reviewByIdBloc.dainStream();

    if (checkFilter) {
      _getMoreData();
    } else {
      _getMoreDataFliter();
    }
    print(checkFilter);
  }

  void _onLoading() {
    Future.delayed(const Duration(milliseconds: 2000)).then((val) {
      _getMoreData();
    });
  }

  void _onRefresh() {
    Future.delayed(const Duration(milliseconds: 2000)).then((val) {
      if (mounted) {
        _controller1.refreshCompleted();
        _getMoreData();
      }

//                refresher.sendStatus(RefreshStatus.completed);
    });
  }

  void _getMoreData() async {
    reviewByIdBloc.getReview(product.id, currentPage, pageSize);
    reviewByIdBloc.getSizeListReview(product.id).then((value) {
      if (mounted) {
        setState(() {
          count = value;
        });
      }
    });
    reviewByIdBloc.getAllList(product.id).then((list) {
      if (mounted) {
        setState(() {
          listAllReview = list;
        });
      }
    });
    if (mounted) {
      _controller1.loadComplete();
      currentPage++;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
  }

  bool checkUserReviewed(List<Review> reviews, int userId) {
    for (int i = 0; i < reviews.length; i++) {
      if (reviews[i].userId == userId) {
        reviewId = reviews[i].id;
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: StreamBuilder<List<Review>>(
        stream: reviewByIdBloc.subject,
        builder: (context, AsyncSnapshot<List<Review>> snapshot) {
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

  Widget _buildReviewWidget(List<Review> data) {
    reviews = data;
    return SmartRefresher(
      controller: _controller1,
      onLoading: _onLoading,
      onRefresh: _onRefresh,
      enablePullUp: true,
      enablePullDown: true,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(right: 12, left: 7, top: 10),
          child: Column(
            children: [
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
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        child: checkUserReviewed(
                                listAllReview,
                                User.fromJsonProfile(storage.getItem('user'))
                                    .id)
                            ? RaisedButton.icon(
                                // Đã review rồi thì chỉ được update
                                onPressed: () {
                                  print(reviewId);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return dialogUpdateReview(context,
                                            product, "Cập nhật review");
                                      });
                                },
                                icon: Icon(
                                  EvaIcons.edit,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Cập nhật review",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.0,
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.blueGrey,
                              )
                            : RaisedButton.icon(
                                // chưa review hiện viết review
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return dialogReview(
                                            context, product, "Viết review");
                                      });
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
                      getFilterBarUI(count),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: listReview(reviews),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFilterBarUI(int count) {
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
                    child: count == 0
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
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return dialogFilter(
                                context, product, "Filter review");
                          });
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

  //*
//*
//*
//*
// *
// list các user review bao ngoài các review bên trong
  Widget listReview(List<Review> reviews) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Container(
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
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black54.withOpacity(0.1),
                            offset: new Offset(1.0, 3.0),
                            blurRadius: 3.7),
                      ]),
                  child: Row(
                    children: [
                      Container(
                        width: 65.0,
                        height: 65.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image:
                                new NetworkImage(reviews[index].user.avatarUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50.0)),
                          border: new Border.all(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 10, top: 10),
                            child: Text(
                              reviews[index].user.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 10, bottom: 10),
                          //   child: Text(
                          //     reviews[index]
                          //             .user
                          //             .industryExperts[0]
                          //             .industry
                          //             .name
                          //             .isEmpty
                          //         ? "Chưa có"
                          //         : reviews[index]
                          //             .user
                          //             .industryExperts[0]
                          //             .industry
                          //             .name,
                          //     style: TextStyle(
                          //       fontSize: 17,
                          //       fontWeight: FontWeight.w300,
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                reviewOfList(
                  reviews[index].reviewAnswers,
                  reviews[index].rate,
                  Jiffy(reviews[index].completeOn).yMMMMd,
                )
              ],
            ),
          ),
        );
      },
    );
  }

//*
//*
//*
//*
// *
//các câu hỏi và câu trả lời bên trong các list review
  Widget reviewOfList(
      List<ReviewAnswer> reviewByUser, double rate, String time) {
    List<String> listIdQuestion = ["7", "8", "9", "10"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
              child: starRating(rate),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                time,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        Column(children: [
          ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: reviewByUser.length,
            itemBuilder: (context, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (reviewByUser[index]
                        .questionId
                        .toString()
                        .contains("6")) ...[
                      textTitle(reviewByUser[index].answer)
                    ] else if (listIdQuestion.contains(
                        reviewByUser[index].questionId.toString())) ...[
                      // textTitle("Bạn thích gì nhất ở ứng dụng?"),
                      textQuestion(reviewByUser[index].question.questionText),
                      textAnswer(reviewByUser[index].answer),
                    ]
                  ]);
            },
          )
        ])
      ],
    );
  }

  Widget textQuestion(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget textAnswer(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.28,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget textTitle(String text) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "\"$text\"",
            style: TextStyle(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.27,
            ),
          ),
        )
      ],
    );
  }

  Widget starRating(double rate) {
    return RatingBarIndicator(
      rating: rate,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 25,
      direction: Axis.horizontal,
    );
  }

  Widget dialogReview(BuildContext context, Product product, String title) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Text('$title ${product.name}')),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  if (await confirm(
                    context,
                    title: Text('Xác nhận'),
                    content: Text('Bạn muốn dừng viết review ?'),
                    textOK: Text('Có'),
                    textCancel: Text('Không'),
                  )) {
                    return Navigator.of(context).pop();
                  }
                  return null;
                })
          ]),
      content: Container(
        width: double.maxFinite,
        child: QuestionReviewPage(
          product: product,
        ),
      ),
    );
  }

  Widget dialogUpdateReview(
      BuildContext context, Product product, String title) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Text('$title ${product.name}')),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  if (await confirm(
                    context,
                    title: Text('Xác nhận'),
                    content: Text('Bạn muốn dừng cập nhật review ?'),
                    textOK: Text('Có'),
                    textCancel: Text('Không'),
                  )) {
                    return Navigator.of(context).pop();
                  }
                  return null;
                })
          ]),
      content: Container(
        width: double.maxFinite,
        child: UpdateReviewPage(
          product: product,
          reviewId: reviewId,
        ),
      ),
    );
  }

  Widget dialogFilter(BuildContext context, Product product, String title) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              '$title ${product.name}',
              softWrap: true,
            )),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop())
          ]),
      content: Container(
        width: double.maxFinite,
        child: ListCheckBoxFilterStar(),
      ),
      actions: [
        RaisedButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new DetailPage(
                page: 1,
                product: product,
                checkFilter: false,
              ),
            ),
          );
        }),
      ],
    );
  }

  void _getMoreDataFliter() async {
    print("aaaa");
    reviewByIdBloc.getReview(product.id, 1, 1);
    reviewByIdBloc.getSizeListReview(product.id).then((value) {
      if (mounted) {
        setState(() {
          count = value;
        });
      }
    });
    reviewByIdBloc.getAllList(product.id).then((list) {
      if (mounted) {
        setState(() {
          listAllReview = list;
        });
      }
    });
    if (mounted) {
      _controller1.loadComplete();
      currentPage++;
    }
  }
}
