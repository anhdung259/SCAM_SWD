import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_QuestionReview_Bloc.dart';
import 'package:swd_project/Model/QuestionReview.dart';
import 'package:swd_project/Widget/RadioButton.dart';

class ListYesNoQuestion extends StatefulWidget {
  @override
  _ListYesNoQuestionState createState() => _ListYesNoQuestionState();
}

enum SingingCharacter { Yes, No }

class _ListYesNoQuestionState extends State<ListYesNoQuestion> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionBloc.getListYesNoQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<QuestionReview>>(
        stream: questionBloc.listYesNoQuestion,
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

  Widget _buildListQuestionWidget(List<QuestionReview> data) {
    List<QuestionReview> questions = data;
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  questions[index].questionText,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              RadioButton(),
            ],
          );
        });
  }
}
