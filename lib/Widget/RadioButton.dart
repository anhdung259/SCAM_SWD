import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  @override
  _RadioButtonState createState() => _RadioButtonState();
}

enum SingingCharacter { Yes, No }

class _RadioButtonState extends State<RadioButton> {
  SingingCharacter _choiceText = SingingCharacter.Yes;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              child: ListTile(
                title: const Text('Có'),
                leading: Radio(
                  value: SingingCharacter.Yes,
                  groupValue: _choiceText,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _choiceText = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              width: 150,
              child: ListTile(
                title: const Text('Không'),
                leading: Radio(
                  value: SingingCharacter.No,
                  groupValue: _choiceText,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _choiceText = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
