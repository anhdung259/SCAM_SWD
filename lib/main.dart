import 'package:flutter/material.dart';
import 'package:swd_project/Pages/Homepage.dart';
import 'package:swd_project/Pages/test.dart';

void main() async {
  runApp(MyApp());
  // Map data = {"questionText": "Are you ok?????", "questionType": "Yes/No"};
  // String body = json.encode(data);
  //
  // var url = 'https://scam2020.azurewebsites.net/api/questions';
  // var response = await http.post(url, body: body, headers: {
  //   "Accept": "application/json",
  //   "content-type": "application/json"
  // });
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  //
  // print(await http.read('https://scam2020.azurewebsites.net/api/questions'));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
// "id": 0,
// "questionText": "Bạn muốn gì???",
// "option1": "Bánh ",
// "option2": "Đấm",
// "option3": "Cơm",
// "option4": "Phở",
// "option5": "Phò",
// "selectRange": null,
// "questionType": "Multiple choice",
// "status": null
/// More examples see https://github.com/flutterchina/dio/tree/master/example
