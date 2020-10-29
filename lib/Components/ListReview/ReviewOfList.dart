import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swd_project/Model/ReviewAnswer.dart';

class ReviewOfMember extends StatefulWidget {
  final List<ReviewAnswer> reviewByUser;
  final double rate;
  final String time;

  const ReviewOfMember({Key key, this.reviewByUser, this.rate, this.time})
      : super(key: key);

  @override
  _ReviewOfMemberState createState() =>
      _ReviewOfMemberState(reviewByUser, rate, time);
}

class _ReviewOfMemberState extends State<ReviewOfMember> {
  final List<ReviewAnswer> reviewByUser;
  final double rate;
  final String time;
  List<String> listIdQuestion = ["7", "8", "9", "10"];

  _ReviewOfMemberState(this.reviewByUser, this.rate, this.time);

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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
              child: starRating(rate),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                time,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        Column(children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: reviewByUser.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ]),
              );
            },
          )
        ])
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
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.28,
          color: Colors.black,
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
              fontSize: 21,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.27,
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
