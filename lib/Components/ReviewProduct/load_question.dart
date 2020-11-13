import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Bloc/Media/MediaBoc.dart';
import 'package:swd_project/Bloc/post_Review_Bloc.dart';
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
  Map<int, String> answer = {};
  Map<int, List<String>> multipleAll = {};
  Map<int, List<String>> multiple = {};
  List<String> check = [];
  int _size = 0;
  Set<String> urls = Set();
  List<File> _selectedFiles = [];
  List<StorageUploadTask> _tasks = [];
  List<Widget> uploadingFiles = [];
  List<Widget> uploadedFiles = [];
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

    multipleAll.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        listReviewAnswer.add(new Answer(
            User.fromJsonProfile(storage.getItem('user')).id,
            key,
            value[i],
            testStatus(value[i])));
      }
    });
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
          ButtonTheme(
            minWidth: 200,
            height: 50,
            child: RaisedButton(
              color: Colors.green,
              child: Text(
                "Upload",
                style: TextStyle(fontWeight: FontWeight.bold),
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
                  side: BorderSide(color: Colors.green)),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(2.0),
              child: Column(
                children: uploadingFiles,
              )),
          SizedBox(
            height: 20,
          ),
          RaisedButton.icon(
            onPressed: () async{
              List<String> temps = [];
              for(StorageUploadTask t in _tasks){
                if (t.isComplete){
                  await getLinkLocation(t).then((value) => temps.add(value));
                }
              }
              setState(() {
                listURL = temps;
              });
              if (_formKey.currentState.validate()) {
                addDataAnswer();
                showProgress(context);
              }
            },
            label: Text(
              "Đăng review",
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
      await await postReviewBloc.postReview(new AnswerPost(
        userReview: new UserReview(
            status: true,
            userId: User.fromJsonProfile(storage.getItem('user')).id,
            rate: rate,
            productId: product.id),
        reviewAnswers: listReviewAnswer,
        userReviewMedia: null,
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
                return 'Vui lòng không để trống!';
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
          child: RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              // answer.update(qr.id, (v) => rating.toString(),
              //     ifAbsent: () => rating.toString());
              setState(() {
                rate = rating;
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
}
