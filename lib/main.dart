import 'package:flutter/material.dart';

import 'Components/SignIn/SigninScreen.dart';

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
      home: signinScreen(),
    );
  }
}
