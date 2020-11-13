import 'package:flutter/material.dart';

class BuildLoading extends StatefulWidget {
  @override
  _BuildLoadingState createState() => _BuildLoadingState();
}

class _BuildLoadingState extends State<BuildLoading> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }
}

class BuildError extends StatefulWidget {
  final String error;

  const BuildError({Key key, this.error}) : super(key: key);
  @override
  _BuildErrorState createState() => _BuildErrorState(error);
}

class _BuildErrorState extends State<BuildError> {
  final String error;

  _BuildErrorState(this.error);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }
}
