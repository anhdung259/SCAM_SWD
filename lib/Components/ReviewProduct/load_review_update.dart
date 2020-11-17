import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:localstorage/localstorage.dart';
import 'package:darq/darq.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:swd_project/Bloc/postOrDelete_Review_Bloc.dart';
import 'package:swd_project/Bloc/update_Review_Bloc.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/QuestionReview/QuestionReview.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewAnswer.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewList.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Pages/detail_product.dart';
import 'package:swd_project/Widget/MultipleChoice.dart';
import 'package:swd_project/Widget/RadioButton.dart';
import 'package:sweetalert/sweetalert.dart';

class UpdateReview extends StatefulWidget {
  final Review review;
  final Product product;

  const UpdateReview({Key key, this.review, this.product}) : super(key: key);

  @override
  _UpdateReviewState createState() => _UpdateReviewState(review, product);
}

class _UpdateReviewState extends State<UpdateReview> {
  final LocalStorage storage = LocalStorage('user');
  var _formKey = GlobalKey<FormState>();
  final Review review;
  final Product product;

  int userId;
  double rate;

  _UpdateReviewState(this.review, this.product);

  // List<TextEditingController> _controller;
  List<AnswerVer2> listReviewAnswer = [];
  Map<int, String> answer = {};
  Map<int, List<String>> multiple = {};
  Map<int, List<String>> multipleAll = {};
  List<int> listReviewAnswerId = [];

  // int _size = 0;
  List<String> check = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAnswerMultiple(17);
  }

  testStatus(String value) {
    if (check.contains(value)) {
      return true;
    }
    return false;
  }

  getAnswerMultiple(int idQuestion) {
    List<String> listAnswerMp = [];
    List<ReviewAnswer> list = review.reviewAnswers
        .where((e) => e.questionId == idQuestion && e.status == true)
        .toList();
    for (int i = 0; i < list.length; i++) {
      listAnswerMp.add(list[i].answer);
    }
    return listAnswerMp;
  }

  getRvId(String answer) {
    List<ReviewAnswer> list = review.reviewAnswers
        .where((e) => e.question.questionType.contains("Multiple choice"))
        .toList();
    for (int i = 0; i < list.length; i++) {
      if (list[i].answer == answer) {
        return list[i].id;
      }
    }
  }

  updateData() {
    listReviewAnswer = answer.entries
        .map((entry) => AnswerVer2(entry.key, entry.value, false))
        .toList();
    multiple.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        check.add(value[i]);
      }
    });

    multipleAll.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        listReviewAnswer.add(
            new AnswerVer2(getRvId(value[i]), value[i], testStatus(value[i])));
      }
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Không"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = FlatButton(
      child: Text("Có"),
      onPressed: () {
        showProgressDelete(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Xác nhận"),
      content: Text(
        "Bạn có chắc chắn muốn xóa review?",
        textAlign: TextAlign.center,
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // showConfirm(BuildContext context) {
  //   SweetAlert.show(context,
  //       title: "Bạn có chắc chắn muốn xóa bài đăng",
  //       confirmButtonText: "Có",
  //       cancelButtonText: "Không",
  //       style: SweetAlertStyle.confirm,
  //       showCancelButton: true, onPress: (bool isConfirm) {
  //     if (isConfirm) {
  //
  //     }
  //     Navigator.of(context).pop();
  //
  //     return false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<ReviewAnswer> listDistinct = review.reviewAnswers
        .distinct((e) => e.questionId)
        .toList(); //những thằng có nhiều questionId
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 140),
            child: RaisedButton.icon(
              color: Colors.red,
              onPressed: () async {
                // postOrDeleteReviewBloc.deleteReview(review.id);
                showAlertDialog(context);
              },
              icon: Icon(
                EvaIcons.trash2Outline,
                color: Colors.white,
              ),
              label: Text(
                "Xóa bài đánh giá",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              itemCount: listDistinct.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (listDistinct[index]
                          .question
                          .questionType
                          .contains("Text"))
                        textField(listDistinct[index].question, index,
                            listDistinct[index].answer, listDistinct[index].id)
                      else if (listDistinct[index]
                          .question
                          .questionType
                          .contains("Yes/No"))
                        yesNoQuestion(listDistinct[index].question,
                            listDistinct[index].answer, listDistinct[index].id)
                      else if (listDistinct[index]
                          .question
                          .questionType
                          .contains("Multiple choice"))
                        multipleQuestion(
                            listDistinct[index].question,
                            getAnswerMultiple(listDistinct[index].questionId),
                            listDistinct[index].questionId),
                    ],
                  ),
                );
              }),
          ratingQuestion(review.rate),
          SizedBox(
            height: 20,
          ),
          RaisedButton.icon(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                updateData();
                showProgress(context);
              }
            },
            label: Text(
              "Cập nhật review",
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              EvaIcons.arrowCircleUp,
              color: Colors.white,
            ),
            color: Color.fromARGB(255, 18, 32, 50),
          )
        ],
      ),
    );
  }

  Future getFuture() {
    return Future(() async {
      await updateReviewBloc.updateReview(new AnswerUpdate(
        userUpdateReview: new UserUpdateReview(
            id: review.id,
            status: true,
            userId: User.fromJsonProfile(storage.getItem('user')).id,
            rate: rate == null ? review.rate : rate,
            productId: product.id),
        reviewAnswers: listReviewAnswer,
        userReviewMedia: null,
      ));
      return 'Cập nhật review thành công';
    });
  }

  Future deleteFuture() {
    return Future(() async {
      await postOrDeleteReviewBloc.deleteReview(review.id);
      return 'Xóa review thành công';
    });
  }

  Future<void> showProgressDelete(BuildContext context) async {
    var result = await showDialog(
        context: context,
        child:
            FutureProgressDialog(deleteFuture(), message: Text('Deleting...')));
    showResultDelete(context, result);
  }

  Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
        context: context,
        child: FutureProgressDialog(getFuture(), message: Text('Loading...')));
    showResultDialog(context, result);
  }

  void showResultDialog(BuildContext context, String result) {
    SweetAlert.show(context, title: result, style: SweetAlertStyle.success,
        onPress: (bool isConfirm) {
      if (isConfirm) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
              builder: (BuildContext context) => new DetailPage(
                page: 1,
                product: product,
              ),
            ),
            (Route<dynamic> route) => route.isFirst);
      }
      return false;
    });
  }

  void showResultDelete(BuildContext context, String result) {
    SweetAlert.show(context, title: result, style: SweetAlertStyle.success,
        onPress: (bool isConfirm) {
      if (isConfirm) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
              builder: (BuildContext context) => new DetailPage(
                page: 1,
                product: product,
              ),
            ),
            (Route<dynamic> route) => route.isFirst);
      }
      return false;
    });
  }

  Widget textField(QuestionReview questionReview, int index, String answerUser,
      int userReviewId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "* ",
                  style: TextStyle(color: Colors.red, fontSize: 17)),
              TextSpan(
                text: questionReview.questionText,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.27),
              ),
            ]))),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                new BoxShadow(
                    color: Colors.black54.withOpacity(0.5),
                    offset: new Offset(1.0, 1.0),
                    blurRadius: 3.7),
              ]),
          height: 100,
          child: TextFormField(
            maxLines: 7,
            initialValue: answerUser ?? "empty",
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
            validator: (value) {
              if (value.length == 0) {
                return 'Vui lòng không để trống!';
              }
              return null;
            },
            onChanged: (value) {
              answer.update(userReviewId, (v) => value, ifAbsent: () => value);
            },
          ),
        ),
      ],
    );
  }

  Widget ratingQuestion(
    double rateUpdate,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: Text(
            "Bạn đánh giá bao nhiêu sao cho sản phẩm ?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          child: SmoothStarRating(
            rating: rateUpdate,
            isReadOnly: false,
            size: 50,
            color: Colors.yellow,
            borderColor: Colors.grey,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: true,
            spacing: 2.0,
            onRated: (value) {
              setState(() {
                rate = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget yesNoQuestion(QuestionReview qr, String answerUser, int userReviewId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            qr.questionText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        RadioButton(
          questionId: userReviewId,
          answer: answer,
          answerUser: answerUser,
        ),
      ],
    );
  }

  Widget multipleQuestion(QuestionReview qr, List<String> listAnswer, int id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            qr.questionText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          child: Column(
            children: [
              MultipleChoice(
                qr: qr,
                answerMultiple: multiple,
                answerFromUser: listAnswer,
                answerMultipleAll: multipleAll,
                userReviewId: id,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
