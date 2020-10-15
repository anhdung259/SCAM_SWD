import 'package:flutter/material.dart';
import 'package:swd_project/Pages/Homepage.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

/// More examples see https://github.com/flutterchina/dio/tree/master/example
