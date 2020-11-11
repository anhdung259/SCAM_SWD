import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Model/QuestionReview/QuestionReview.dart';

// ignore: must_be_immutable
class MultipleChoice extends StatefulWidget {
  final QuestionReview qr;
  int userReviewId;
  List<String> answerFromUser = [];
  Map<int, List<String>> answerMultiple = {};
  Map<int, List<String>> answerMultipleAll = {};
  List<int> listReviewAnswerId = [];
  MultipleChoice(
      {Key key,
      this.qr,
      this.answerMultiple,
      this.answerFromUser,
      this.userReviewId,
      this.answerMultipleAll,
      this.listReviewAnswerId})
      : super(key: key);

  @override
  _MultipleChoiceState createState() => _MultipleChoiceState(qr, answerMultiple,
      answerFromUser, userReviewId, answerMultipleAll, listReviewAnswerId);
}

class Multiple {
  bool status;
  String answer;

  Multiple(this.status, this.answer);
}

class _MultipleChoiceState extends State<MultipleChoice> {
  QuestionReview qr;
  Map<int, List<String>> answerMultiple = {};
  Map<int, List<String>> answerMultipleAll = {};

  List<String> answerFromUser = [];
  int userReviewId;
  _MultipleChoiceState(this.qr, this.answerMultiple, this.answerFromUser,
      this.userReviewId, this.answerMultipleAll, this.listReviewAnswerId);
  List<String> tags = [];
  List<String> options = [];
  List<Multiple> optionMultiple = [];
  List<int> listReviewAnswerId = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    options.add(qr.option1);
    options.add(qr.option2);
    options.add(qr.option3);
    options.add(qr.option4);
    options.add(qr.option5);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ChipsChoice<String>.multiple(
        choiceStyle: const C2ChoiceStyle(
          color: Colors.indigo,
          borderOpacity: .3,
        ),
        choiceActiveStyle: const C2ChoiceStyle(
          color: Colors.indigo,
          brightness: Brightness.dark,
        ),
        wrapped: true,
        value: answerFromUser,
        onChanged: (val) => setState(() {
          answerFromUser = val;
          answerMultiple.update(userReviewId, (value) => answerFromUser,
              ifAbsent: () => answerFromUser);

          answerMultipleAll.update(userReviewId, (value) => options,
              ifAbsent: () => options);
        }),
        choiceItems: C2Choice.listFrom<String, String>(
          source: options,
          value: (i, v) => v,
          label: (i, v) => v,
          tooltip: (i, v) => v,
        ),
      )
    ]);

    // title: 'Scrollable List Multiple Choice',
    // child: ChipsChoice<String>.multiple(
    //   value: tags,
    //   onChanged: (val) => setState(() => tags = val),
    //   choiceItems: C2Choice.listFrom<String, String>(
    //     source: options,
    //     value: (i, v) => v,
    //     label: (i, v) => v,
    //     tooltip: (i, v) => v,
    //   ),
  }
}
