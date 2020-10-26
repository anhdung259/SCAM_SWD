import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_QuestionReview_Bloc.dart';
import 'package:swd_project/Bloc/Post_Review_Bloc.dart';
import 'package:swd_project/Components/TestLoadQuestion.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/QuestionReviewResponse.dart';

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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 32, 50),
        title: Text("Review ${product.name}"),
        centerTitle: true,
      ),
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 30),
                    child: LoadQuestionReview(
                      questions: snapshot.data.questions,
                    ),
                  ),
                ],
              ),
            );
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
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
}
