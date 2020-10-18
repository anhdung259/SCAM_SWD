import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Widget/PercentBox.dart';

class ListCheckBoxFilterStar extends StatefulWidget {
  @override
  _ListCheckBoxFilterStarState createState() => _ListCheckBoxFilterStarState();
}

class _ListCheckBoxFilterStarState extends State<ListCheckBoxFilterStar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PercentReviewBox(
              percent: 0.9,
              text: "5 sao",
            ),
            SizedBox(
              height: 1,
            ),
            PercentReviewBox(
              percent: 0.7,
              text: "4 sao",
            ),
            SizedBox(
              height: 1,
            ),
            PercentReviewBox(
              percent: 0.5,
              text: "3 sao",
            ),
            SizedBox(
              height: 1,
            ),
            PercentReviewBox(
              percent: 0.4,
              text: "2 sao",
            ),
            SizedBox(
              height: 1,
            ),
            PercentReviewBox(
              percent: 0.1,
              text: "1 sao",
            ),
          ],
        ));
  }
}
