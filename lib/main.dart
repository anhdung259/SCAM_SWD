import 'package:flutter/material.dart';
import 'package:swd_project/Pages/home_page.dart';
import 'Components/SignIn/signin_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
