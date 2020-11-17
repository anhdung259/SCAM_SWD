import 'dart:io';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:localstorage/localstorage.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:swd_project/Bloc/Media/MediaBoc.dart';
import 'package:swd_project/Bloc/post_Feature_review_Bloc.dart';
import 'package:swd_project/Bloc/postOrDelete_Review_Bloc.dart';
import 'package:swd_project/Model/Feature/feature.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/QuestionReview/QuestionReview.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewAnswer.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Pages/detail_product.dart';
import 'package:swd_project/Widget/MultipleChoice.dart';
import 'package:swd_project/Widget/RadioButton.dart';
import 'package:sweetalert/sweetalert.dart';

class LoadQuestionReview extends StatefulWidget {
  final List<QuestionReview> questions;
  final Product product;

  const LoadQuestionReview({Key key, this.questions, this.product})
      : super(key: key);

  @override
  _LoadQuestionReviewState createState() =>
      _LoadQuestionReviewState(questions, product);
}

class _LoadQuestionReviewState extends State<LoadQuestionReview> {
  final LocalStorage storage = LocalStorage('user');
  var _formKey = GlobalKey<FormState>();
  final List<QuestionReview> questions;
  final Product product;
  int userId;
  double rate;

  _LoadQuestionReviewState(this.questions, this.product);

  List<TextEditingController> _controller;
  List<Answer> listReviewAnswer = [];
  List<UserReviewMedia> listReviewMedia = [];
  Map<int, String> answer = {};
  Map<int, String> answerFeature = {};
  Map<int, List<String>> multipleAll = {};
  Map<int, List<String>> multiple = {};
  List<String> check = [];
  int _size = 0;
  Set<String> urls = Set();
  List<File> _selectedFiles = [];
  List<StorageUploadTask> _tasks = [];
  List<Widget> uploadingFiles = [];
  List<Widget> uploadedFiles = [];
  List<ProductFeature> features = [];
  List<FeatureReview> listFeatureReview = [];

  //goi link media cho nay
  List<String> listURL;

  getSizeList() {
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].questionType.contains("Text")) {
        _size++;
      }
    }
    return _size;
  }

  testStatus(String value) {
    if (check.contains(value)) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    features = product.productFeatures;
    _controller =
        List.generate(getSizeList(), (index) => TextEditingController());
  }

  addDataAnswer() {
    listReviewAnswer = answer.entries
        .map((entry) => Answer(User.fromJsonProfile(storage.getItem('user')).id,
            entry.key, entry.value, false))
        .toList();
    multiple.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        check.add(value[i]);
      }
    });
//get multiple questions
    multipleAll.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        listReviewAnswer.add(new Answer(
            User.fromJsonProfile(storage.getItem('user')).id,
            key,
            value[i],
            testStatus(value[i])));
      }
    });
    //get video and img
    // List<String> temps = [];
    // for (StorageUploadTask t in _tasks) {
    //   if (t.isComplete) {
    //     await getLinkLocation(t).then((value) => temps.add(value));
    //   }
    // }
    // setState(() {
    //   listURL = temps;
    // });
  }

  Widget futureBuilderUpload(File file) {
    return FutureBuilder(
      future: uploadImages(file, _tasks),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget child = snapshot.data == null ? Text('Loading') : snapshot.data;
        return child;
      },
    );
  }

  Widget futureBuilderDownload(StorageUploadTask task) {
    return FutureBuilder(
      future: fetchImages(task),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget child = snapshot.data == null ? Text('Loading') : snapshot.data;
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (questions[index].questionType.contains("Text"))
                        textField(questions[index], index)
                      else if (questions[index].questionType.contains("Yes/No"))
                        yesNoQuestion(questions[index])
                      else if (questions[index]
                          .questionType
                          .contains("Multiple choice"))
                        multipleQuestion(questions[index], questions[index].id)
                    ],
                  ),
                );
              }),
          ratingQuestion(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return dialogReviewFeature(
                              context, product, "Đánh giá tính năng");
                        });
                  },
                  child: Text(
                    "Đánh giá tính năng",
                  ),
                ),
              ),
              RaisedButton.icon(
                color: Colors.black54,
                label: Text(
                  "Upload media",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () async {
                  List<Widget> tempFiles = [];
                  FilePickerResult result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['mp4', 'jpg', 'png'],
                    allowMultiple: true,
                  );
                  if (result != null) {
                    setState(() {
                      _selectedFiles.clear();
                      _selectedFiles =
                          result.paths.map((path) => File(path)).toList();
                    });
                    for (File file in _selectedFiles) {
                      tempFiles.add(futureBuilderUpload(file));
                    }
                    setState(() {
                      uploadingFiles = tempFiles;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.all(2.0),
              child: Column(
                children: uploadingFiles,
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            height: 50,
            child: RaisedButton.icon(
              onPressed: () async {
                List<String> temps = [];
                for (StorageUploadTask t in _tasks) {
                  if (t.isComplete) {
                    await getLinkLocation(t).then((value) => temps.add(value));
                  }
                }
                setState(() {
                  if (_formKey.currentState.validate()) {
                    listURL = temps;
                  } else {
                    showErrorDialog(context);
                  }
                });
                for (int i = 0; i < listURL.length; i++) {
                  listReviewMedia.add(UserReviewMedia(
                      title: "VideoUpload",
                      url: listURL[i],
                      mediaType: listURL[i].contains('.jpg') ||
                              listURL[i].contains('.png') ||
                              listURL[i].contains('.jpeg')
                          ? 'image'
                          : 'video',
                      id: i,
                      userReviewId: 1));
                }
                if (_formKey.currentState.validate()) {
                  addDataAnswer();
                  showProgress(context);
                } else {
                  showErrorDialog(context);
                }
              },
              label: Text(
                "Đăng review",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              icon: Icon(
                EvaIcons.arrowCircleUp,
                color: Colors.white,
              ),
              color: Color.fromARGB(255, 18, 32, 50),
            ),
          )
        ],
      ),
    );
  }

  Future getFuture() {
    return Future(() async {
      await postOrDeleteReviewBloc.postReview(new AnswerPost(
        userReview:
            new UserReview(status: true, rate: rate, productId: product.id),
        reviewAnswers: listReviewAnswer,
        userReviewMedia: listReviewMedia,
      ));
      return 'Đăng bài review thành công';
    });
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
              builder: (context) => new DetailPage(
                page: 1,
                product: product,
              ),
            ),
            (Route<dynamic> route) => route.isFirst);
      }
      return false;
    });
  }

  void showErrorDialog(BuildContext context) {
    SweetAlert.show(context,
        title: "Vui lòng không để trống!",
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      if (isConfirm) {
        Navigator.of(context).pop();
      }
      return false;
    });
  }

  Widget textField(QuestionReview questionReview, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(TextSpan(children: [
              TextSpan(text: "* ", style: TextStyle(color: Colors.red)),
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
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
            validator: (value) {
              if (value.length == 0) {
                return 'Không để trống mục này!';
              }
              return null;
            },
            controller: _controller[index],
            onChanged: (value) {
              answer.update(questionReview.id, (v) => value,
                  ifAbsent: () => value);
            },
          ),
        ),
      ],
    );
  }

  Widget ratingQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, bottom: 20),
          child: Text(
            "Bạn đánh giá bao nhiêu sao cho sản phẩm ?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          child: SmoothStarRating(
            rating: 0,
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

  Widget yesNoQuestion(QuestionReview qr) {
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
          questionId: qr.id,
          answer: answer,
        ),
      ],
    );
  }

  Widget multipleQuestion(QuestionReview qr, int idReview) {
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
                userReviewId: idReview,
                answerMultipleAll: multipleAll,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget updateFeature() {
    if (features.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Chưa có dữ liệu ",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ListView.builder(
                itemCount: features.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                features[index].feature.featureName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    letterSpacing: 0.27,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Container(
                            child: SmoothStarRating(
                          rating: 0,
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
                            answerFeature.update(features[index].feature.id,
                                (v) => value.toString(),
                                ifAbsent: () => value.toString());
                          },
                        )),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              width: 400,
              height: 50,
              child: RaisedButton.icon(
                onPressed: () async {
                  getDataReviewFeature();
                  showProgressFeature(context);
                },
                label: Text(
                  "Đánh giá tính năng",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                icon: Icon(
                  EvaIcons.arrowCircleUp,
                  color: Colors.white,
                ),
                color: Color.fromARGB(255, 18, 32, 50),
              ),
            )
          ],
        ),
      );
  }

  getDataReviewFeature() {
    listFeatureReview = answerFeature.entries
        .map(
          (entry) => FeatureReview(
              featureId: entry.key,
              id: 0,
              productId: product.id,
              rate: entry.value,
              userId: User.fromJsonProfile(storage.getItem('user')).id),
        )
        .toList();
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
                    content: Text('Bạn muốn dừng cập nhật tính năng ?'),
                    textOK: Text('Có'),
                    textCancel: Text('Không'),
                  )) {
                    return Navigator.of(context).pop();
                  }
                  return null;
                })
          ]),
      content: Container(width: double.maxFinite, child: updateFeature()),
    );
  }

  Future<void> showProgressFeature(BuildContext context) async {
    var result = await showDialog(
        context: context,
        child: FutureProgressDialog(getFutureFeature(),
            message: Text('Loading...')));
    showResultFeatureDialog(context, result);
  }

  Future getFutureFeature() {
    return Future(() async {
      await postFeatureReviewBloc.postFeatureReview(listFeatureReview);
      return 'Đánh giá thành công';
    });
  }

  void showResultFeatureDialog(BuildContext context, String result) {
    SweetAlert.show(context, title: result, style: SweetAlertStyle.success,
        onPress: (bool isConfirm) {
      if (isConfirm) {
        Navigator.of(context).pop();
      }
      return false;
    });
  }
}
