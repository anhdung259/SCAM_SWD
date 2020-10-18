import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultipleChoice extends StatefulWidget {
  final String text;

  const MultipleChoice({Key key, this.text}) : super(key: key);
  @override
  _MultipleChoiceState createState() => _MultipleChoiceState(text);
}

class _MultipleChoiceState extends State<MultipleChoice> {
  bool _unchecked = false;
  final String text;

  _MultipleChoiceState(this.text);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Expanded(
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
          ],
        ));
  }
}
