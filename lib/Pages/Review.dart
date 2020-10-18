import 'package:flutter/material.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Widget/ListMultipleQuestion.dart';
import 'package:swd_project/Widget/ListRatingQuestion.dart';
import 'package:swd_project/Widget/ListTextQuestion.dart';
import 'package:swd_project/Widget/ListYesNoQuestion.dart';

class QuestionReviewPage extends StatefulWidget {
  final Product product;

  const QuestionReviewPage({Key key, this.product}) : super(key: key);

  @override
  _QuestionReviewPageState createState() => _QuestionReviewPageState(product);
}

class _QuestionReviewPageState extends State<QuestionReviewPage> {
  final Product product;

  _QuestionReviewPageState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 32, 50),
          title: Text("Review ${product.name}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ListRating(),
              ),
              ListQuestionText(),
              ListYesNoQuestion(),
              ListMultiple(),
            ],
          ),
        ));
  }
}
