import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_QuestionReview_Bloc.dart';
import 'package:swd_project/Model/QuestionReview.dart';

class ListQuestionText extends StatefulWidget {
  @override
  _ListQuestionTextState createState() => _ListQuestionTextState();
}

class _ListQuestionTextState extends State<ListQuestionText> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionBloc.getListTextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QuestionReview>>(
      stream: questionBloc.listTextQuestion,
      builder: (context, AsyncSnapshot<List<QuestionReview>> snapshot) {
        if (snapshot.hasData) {
          // if (snapshot.data.error != null && snapshot.data.error.length > 0) {
          //   return _buildErrorWidget(snapshot.data.error);
          // }
          return _buildListQuestionWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
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

  Widget _buildListQuestionWidget(List<QuestionReview> data) {
    List<QuestionReview> questions = data;
    return Container(
      height: 113 * questions.length.toDouble(),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    questions[index].questionText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
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
                  height: 70,
                  child: TextFormField(
                    maxLines: 5,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
