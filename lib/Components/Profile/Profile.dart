import 'package:flutter/material.dart';
import 'package:swd_project/Model/UserReview.dart';

class ProfileUser extends StatefulWidget {
  final User user;

  const ProfileUser({Key key, this.user}) : super(key: key);
  @override
  _ProfileUserState createState() => _ProfileUserState(user);
}

class _ProfileUserState extends State<ProfileUser> {
  final User user;

  _ProfileUserState(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(user.name),
      ],
    );
  }
}
