import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swd_project/Bloc/Get_QuestionReview_Bloc.dart';
import 'package:swd_project/Model/QuestionReview.dart';
import 'package:swd_project/Model/QuestionReviewResponse.dart';
import 'package:swd_project/Model/ReviewAnswer.dart';
import 'package:swd_project/Widget/MultipleChoice.dart';
import 'package:swd_project/Widget/RadioButton.dart';

class LoadQuestionReview extends StatefulWidget {
  final List<QuestionReview> questions;
  const LoadQuestionReview({Key key, this.questions}) : super(key: key);

  @override
  _LoadQuestionReviewState createState() => _LoadQuestionReviewState(questions);
}

class _LoadQuestionReviewState extends State<LoadQuestionReview> {
  final List<QuestionReview> questions;
  List<TextEditingController> _controller;
  List<ReviewAnswer> listReviewAnswer = [];
  Map<int, String> answer = {};
  Map<int, List<String>> multiple = {};
  int _size = 0;

  getSizeList() {
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].questionType.contains("Text")) {
        _size++;
      }
    }
    return _size;
  }

  List<int> questionsId = [];

  _LoadQuestionReviewState(this.questions);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    questionBloc.getQuestions();

    _controller =
        List.generate(getSizeList(), (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
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
                      multipleQuestion(questions[index])
                    else if (questions[index]
                        .questionType
                        .contains("Rating scale"))
                      ratingQuestion(questions[index]),
                  ],
                ),
              );
            }),
        RaisedButton(
          onPressed: () {
            // for (int j = 0; j < _controller.length; j++) {
            //   listReviewAnswer.add(
            //       new ReviewAnswer(2, questionsId[j], _controller[j].text));
            // }

            listReviewAnswer = answer.entries
                .map((entry) => ReviewAnswer(2, entry.key, entry.value))
                .toList();
            // answer.forEach((key, value) {
            //   listReviewAnswer.add(new ReviewAnswer(2, key, value));
            // });

            multiple.forEach((key, value) {
              for (int i = 0; i < value.length; i++) {
                listReviewAnswer.add(new ReviewAnswer(2, key, value[i]));
              }
            });
            // print(answer);
            // print(multiple);
            for (int x = 0; x < listReviewAnswer.length; x++) {
              print("${listReviewAnswer[x].questionId} :"
                  "${listReviewAnswer[x].answer}");
            }
          },
          child: Text("Đăng review của bạn"),
          color: Colors.orangeAccent,
        )
      ],
    );
  }
  //
  // Widget optionChoice(String option) {
  //   if (option == null) {
  //     return Container();
  //   }
  //   return MultipleChoice(
  //     text: option,
  //   );
  // }

  Widget textField(QuestionReview questionReview, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            questionReview.questionText,
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
          child: TextField(
            maxLines: 5,
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

  Widget ratingQuestion(QuestionReview qr) {
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
          child: RatingBar(
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
              answer.update(qr.id, (v) => rating.toString(),
                  ifAbsent: () => rating.toString());
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

  Widget multipleQuestion(QuestionReview qr) {
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget Multiple(String text) {
  //   return GestureDetector(
  //       onTap: () {},
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: CheckboxListTile(
  //               title: Text(text),
  //               value: _unchecked,
  //               onChanged: (check) {
  //                 setState(() {
  //                   _unchecked = check;
  //                 });
  //               },
  //               controlAffinity: ListTileControlAffinity.leading,
  //             ),
  //           ),
  //         ],
  //       ));
  // }
}
