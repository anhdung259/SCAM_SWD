import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'choices.dart' as choices;

class FeaturesMultiPopup extends StatefulWidget {
  @override
  _FeaturesMultiPopupState createState() => _FeaturesMultiPopupState();
}

class _FeaturesMultiPopupState extends State<FeaturesMultiPopup> {
  List<String> _fruit = [];
  List<String> _framework = [];
  Map<int, List<String>> multiple = {};
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          value: _fruit,
          onChange: (state) => setState(() {
            _fruit = state.value;
            multiple.update(
              2,
              (value) => _fruit,
              ifAbsent: () => _fruit,
            );
            print(multiple);
          }),
          choiceItems: choices.fruits,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: Container(
                width: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.shopping_cart),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Frameworks',
          value: _framework,
          onChange: (state) => setState(() => _framework = state.value),
          choiceItems: choices.frameworks,
          modalType: S2ModalType.popupDialog,
          tileBuilder: (context, state) {
            return ListTile(
              title: Text(state.title),
              subtitle: Text(
                state.valueDisplay,
                style: const TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(_framework.length.toString(),
                    style: TextStyle(color: Colors.white)),
              ),
              trailing:
                  const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: state.showModal,
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
