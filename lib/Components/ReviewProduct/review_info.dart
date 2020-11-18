import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swd_project/Bloc/get_Feature_Bloc.dart';
import 'package:swd_project/Bloc/get_Review_Bloc.dart';
import 'package:swd_project/Components/FeatureProduct/review_feature.dart';
import 'package:swd_project/Components/FeatureProduct/update_review_feature.dart';
import 'package:swd_project/Components/ReviewProduct/filter_star.dart';
import 'package:swd_project/Model/Feature/feature.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewAnswer.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewList.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Pages/detail_product.dart';
import 'package:swd_project/Pages/review.dart';
import 'package:swd_project/Pages/update_review.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';
import 'package:videos_player/model/control.model.dart';
import 'package:videos_player/model/video.model.dart';
import 'package:videos_player/videos_player.dart';

class ReviewPage extends StatefulWidget {
  final Product product;
  final int pageSize;
  final int currentPage;
  final String queryFilter;

  const ReviewPage(
      {Key key,
      this.product,
      this.pageSize,
      this.currentPage,
      this.queryFilter})
      : super(key: key);

  @override
  _ReviewPageState createState() =>
      _ReviewPageState(product, pageSize, currentPage, queryFilter);
}

class _ReviewPageState extends State<ReviewPage> {
  User user;
  final Product product;
  int count;
  int pageSize;
  int currentPage;
  final String queryFilter;

  _ReviewPageState(
      this.product, this.pageSize, this.currentPage, this.queryFilter);

  bool checkUserReview = false;
  bool checkFeatureReview = false;
  List<Review> reviews;
  List<Review> listAllReview;
  List<FeatureReview> dataReviewFeature;
  int reviewId;

  RefreshController _controller1 = RefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewByIdBloc.dainStream();
    _getMoreDataFliter();
  }

  void _onLoading() {
    Future.delayed(const Duration(milliseconds: 1000)).then((val) {
      _getMoreDataFliter();
    });
  }

  void _onRefresh() {
    Future.delayed(const Duration(milliseconds: 1000)).then((val) {
      if (mounted) {
        _controller1.refreshCompleted();
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
              builder: (context) => new DetailPage(
                page: 1,
                product: product,
              ),
            ),
            (Route<dynamic> route) => route.isFirst);
      }

//                refresher.sendStatus(RefreshStatus.completed);
    });
  }

  void _getMoreDataFliter() async {
    reviewByIdBloc.getReviewFilter(
        product.id, currentPage, pageSize, queryFilter);
    reviewByIdBloc.checkReview(product.id).then((result) {
      if (mounted) {
        setState(() {
          checkUserReview = result;
        });
      }
    });
    featureBloc.listReviewFeature(product.id).then((result) {
      if (mounted) {
        setState(() {
          dataReviewFeature = result;
          dataReviewFeature.isEmpty
              ? checkFeatureReview = true
              : checkFeatureReview = false;
        });
      }
    });
    //
    // reviewByIdBloc.getSizeListReview(product.id).then((value) {
    //   if (mounted) {
    //     setState(() {
    //       count = value;
    //     });
    //   }
    // });
    reviewByIdBloc.getAllList(product.id).then((value) {
      if (mounted) {
        setState(() {
          listAllReview = value;
          count = listAllReview.length;
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
    reviewByIdBloc.dispose();
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
            return BuildError(
              error: snapshot.error,
            );
          } else {
            return BuildLoading();
          }
        },
      ),
    );
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
                        child: checkUserReview
                            ? RaisedButton.icon(
                                // Đã review rồi thì chỉ được update
                                onPressed: () {
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
                                    fontSize: 17,
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
                                    fontSize: 17,
                                    letterSpacing: 0.0,
                                    color: Colors.white,
                                  ),
                                ),
                                color: Color.fromARGB(255, 18, 32, 50),
                              ),
                      ),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        child: checkFeatureReview
                            ? RaisedButton(
                                // Đã review rồi thì chỉ được update
                                child: Text(
                                  "Đánh giá tính năng",
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return dialogReviewFeature(context,
                                            product, "Đánh giá tính năng");
                                      });
                                },
                              )
                            : RaisedButton(
                                // Đã review rồi thì chỉ được update
                                child: Text(
                                  "Cập nhật đánh giá tính năng",
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return dialogUpdateReviewFeature(
                                            context,
                                            product,
                                            "Cập nhật đánh giá tính năng");
                                      });
                                },
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
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 200,
                              height: 20,
                              child: ListView.builder(
                                  itemCount: reviews[index]
                                      .user
                                      .industryExperts
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return Row(
                                      children: [
                                        Text(reviews[index]
                                            .user
                                            .industryExperts[i]
                                            .industry
                                            .name),
                                        SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                reviewOfList(
                  reviews[index].reviewAnswers,
                  reviews[index].userReviewMedia,
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
  Widget reviewOfList(List<ReviewAnswer> reviewByUser,
      List<UserReviewMedia> media, double rate, String time) {
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
          ),
          media.length == 0
              ? Container()
              : Container(
                  height: 180,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: media.length,
                      physics: ScrollPhysics(),
                      // ngao ngao ko scroll này
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(4),
                          child: new GestureDetector(
                            child: new GridTile(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      new BoxShadow(
                                          color:
                                              Colors.black54.withOpacity(0.5),
                                          offset: new Offset(0.1, 2.0),
                                          blurRadius: 3.8),
                                    ]),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (media[index].mediaType == "image")
                                        loadImage(media[index])
                                      else if (media[index].mediaType ==
                                          "video")
                                        loadVideo(media[index])
                                    ]),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ])
      ],
    );
  }

  Widget loadImage(UserReviewMedia media) {
    return Container(
      width: 170,
      height: 170,
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return dialogImg(context, media.url);
              });
        },
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(media.url),
            fit: BoxFit.fill,
          )),
        ),
      ),
    );
  }

  // getThumbnailVideo(String url) async {
  //   final linkThumbnail = await VideoThumbnail.thumbnailFile(
  //     video: url,
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.WEBP,
  //     maxHeight: 64,
  //     // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //     quality: 75,
  //   );
  //   return linkThumbnail;
  // }

  Widget loadVideo(UserReviewMedia media) {
    return Container(
      child: VideosPlayer(
        maxVideoPlayerHeight: 150,
        networkVideos: [
          new NetworkVideo(
              videoUrl: media.url,
              videoControl: new NetworkVideoControl(autoPlay: false),
              id: "1",
              name: "VideoReview")
        ],
      ),
    );
  }

  Widget dialogImg(BuildContext context, String url) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop())
          ]),
      content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 400,
                  height: 550,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.contain,
                  )),
                ),
              ),
            ],
          )),
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
        ),
      ),
    );
  }

  Widget dialogFilter(BuildContext context, Product product, String title) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 90),
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
        child: Filter(
          product: product,
          reviews: listAllReview,
        ),
      ),
    );
  }

  Widget dialogReviewFeature(
      BuildContext context, Product product, String title) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 90),
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
                    content: Text('Bạn muốn dừng đánh giá tính năng ?'),
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
          child: ReviewFeature(
            product: product,
          )),
    );
  }

  Widget dialogUpdateReviewFeature(
      BuildContext context, Product product, String title) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 90),
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
                    content: Text('Bạn muốn dừng cập nhật review tính năng ?'),
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
          child: UpdateReviewFeature(
            product: product,
            featureReview: dataReviewFeature,
          )),
    );
  }
}
