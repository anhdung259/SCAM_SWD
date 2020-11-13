import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/get_QuestionReview_Bloc.dart';
import 'package:swd_project/Components/ReviewProduct/load_question.dart';

import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/QuestionReview/QuestionReviewResponse.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';

class QuestionReviewPage extends StatefulWidget {
  final Product product;

  const QuestionReviewPage({Key key, this.product}) : super(key: key);

  @override
  _QuestionReviewPageState createState() => _QuestionReviewPageState(product);
}

class _QuestionReviewPageState extends State<QuestionReviewPage> {
  final Product product;
  int size;

  _QuestionReviewPageState(this.product);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionBloc.getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, // tránh overcross
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<QuestionReviewResponse>(
        stream: questionBloc.subject,
        builder: (context, AsyncSnapshot<QuestionReviewResponse> snapshot) {
          if (snapshot.hasData) {
            // if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            //   return _buildErrorWidget(snapshot.data.error);
            // }
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: LoadQuestionReview(
                        questions: snapshot.data.questions,
                        product: product,
                      ),
                    ),
                  ],
                ),
              ),
            );
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
}
