import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swd_project/Model/ReviewAnswer.dart';

class ReviewOfMember extends StatefulWidget {
  final List<ReviewAnswer> reviewByUser;
  final double rate;

  const ReviewOfMember({Key key, this.reviewByUser, this.rate})
      : super(key: key);

  @override
  _ReviewOfMemberState createState() =>
      _ReviewOfMemberState(reviewByUser, rate);
}

class _ReviewOfMemberState extends State<ReviewOfMember> {
  final List<ReviewAnswer> reviewByUser;
  final double rate;
  List<String> listIdQuestion = ["7", "8", "9", "10"];
  _ReviewOfMemberState(this.reviewByUser, this.rate);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: starRating(rate),
        ),
        Container(
            padding: EdgeInsets.all(13),
            height: 350,
            child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: reviewByUser.length,
              itemBuilder: (context, index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (reviewByUser[index]
                          .questionId
                          .toString()
                          .contains("6")) ...[
                        textTitle(reviewByUser[index].answer)
                      ] else if (listIdQuestion.contains(
                          reviewByUser[index].questionId.toString())) ...[
                        // textTitle("Bạn thích gì nhất ở ứng dụng?"),
                        textQuestion(reviewByUser[index].question.questionText),
                        textAnswer(reviewByUser[index].answer),
                      ]
                    ]);
              },
            ))
      ],
    );
  }

  Widget textQuestion(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget textAnswer(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget textTitle(String text) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "\"$text\"",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        )
      ],
    );
  }

  Widget starRating(double rate) {
    return RatingBarIndicator(
      rating: rate,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 25,
      direction: Axis.horizontal,
    );
  }
}
