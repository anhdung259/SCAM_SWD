import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Model/Category.dart';


Widget _buildLoadingWidget() {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ));
}

Widget _buildErrorWidget(String error) {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ));
}

Widget _buildGenresWidget(List<Category> data) {
  List<Category> genres = data;
  if (genres.length == 0) {
    return Container(
      child: Text("No Genres"),
    );
  } else {
    return null;
  }
}