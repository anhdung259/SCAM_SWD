import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/TaskMenu/User_Bloc.dart';

import 'package:swd_project/Model/UserResponse.dart';
import 'package:swd_project/Model/UserReview.dart';

import 'Profile.dart';

class DetailUser extends StatefulWidget {
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<UserResponse>(
          stream: userBloc.userProfile,
          builder: (context, AsyncSnapshot<UserResponse> snapshot) {
            if (snapshot.hasData) {
              return _buildGenresWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
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

  Widget _buildGenresWidget(UserResponse data) {
    User user = data.user;
    if (user == null) {
      return Container(
        child: Text("No Genres"),
      );
    } else {
      return ProfileUser(
        user: user,
      );
    }
  }
}
