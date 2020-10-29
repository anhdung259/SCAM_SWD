import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentReviewBox extends StatefulWidget {
  final double percent;
  final String text;

  const PercentReviewBox({Key key, this.percent, this.text}) : super(key: key);
  @override
  _PercentReviewBoxState createState() => _PercentReviewBoxState(percent, text);
}

class _PercentReviewBoxState extends State<PercentReviewBox> {
  bool _unchecked = false;
  final double percent;
  final String text;

  _PercentReviewBoxState(this.percent, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
          width: 128,
          height: 40,
          child: CheckboxListTile(
            title: Text(text),
            value: _unchecked,
            onChanged: (check) {
              setState(() {
                _unchecked = check;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 13),
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 200,
            animation: true,
            lineHeight: 21.0,
            animationDuration: 2000,
            percent: percent,
            animateFromLastPercent: true,
            progressColor: Colors.orange[400],
            // maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
          ),
        ),
      ],
    ));
  }
}
