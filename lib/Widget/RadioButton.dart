import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

// ignore: must_be_immutable
class RadioButton extends StatefulWidget {
  Map<int, String> answer = {};
  final int questionId;
  String answerUser;

  RadioButton({Key key, this.questionId, this.answer, this.answerUser})
      : super(key: key);
  @override
  _RadioButtonState createState() =>
      _RadioButtonState(questionId, answer, answerUser);
}

enum SingingCharacter { Yes, No }

class _RadioButtonState extends State<RadioButton> {
  Map<int, String> answer = {};
  final int questionId;
  String answerUser;
  String _verticalGroupValue = " ";
  List<String> _option = ["Có", "Không"];
  _RadioButtonState(this.questionId, this.answer, this.answerUser);
  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>.builder(
      spacebetween: 30,
      groupValue: answerUser == null ? _verticalGroupValue : answerUser,
      onChanged: (value) => setState(() {
        answerUser == null ? _verticalGroupValue = value : answerUser = value;
        setState(() {
          answer.update(questionId, (v) => value, ifAbsent: () => value);
        });
      }),
      items: _option,
      itemBuilder: (item) => RadioButtonBuilder(
        item,
      ),
    );
  }
  // Container(
  //   width: 300,
  //   child: Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,

  // children: [
  //   Container(
  //     width: 150,
  //     child: ListTile(
  //       title: const Text('Có'),
  //       leading: Radio(
  //         value: SingingCharacter.Yes,
  //         groupValue: _choiceText,
  //         onChanged: (SingingCharacter value) {
  //           setState(() {
  //             _choiceText = value;

  //           });
  //         },
  //       ),
  //     ),
  //   ),
  //   Container(
  //     width: 150,
  //     child: ListTile(
  //       title: const Text('Không'),
  //       leading: Radio(
  //         value: SingingCharacter.No,
  //         groupValue: _choiceText,
  //         onChanged: (SingingCharacter value) {
  //           setState(() {
  //             _choiceText = value;
  //             answer.update(questionId, (v) => "Không",
  //                 ifAbsent: () => "Không");
  //           });
  //         },
  //       ),
  //     ),
  //   ),
  // ],

}
