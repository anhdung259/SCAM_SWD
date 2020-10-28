import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Categories_Bloc.dart';
import 'package:swd_project/Bloc/TaskMenu/User_Bloc.dart';
import 'package:swd_project/Model/Category.dart';
import 'package:swd_project/Model/User.dart';
import 'package:swd_project/Model/UserRepository.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    userBloc.getUser(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<UserRepository>(
          stream: userBloc.userProfile,
          builder: (context, AsyncSnapshot<UserRepository> snapshot) {
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

  Widget _buildGenresWidget(UserRepository user) {
    if (user == null) {
      return Container(
        child: Text("No Genres"),
      );
    } else {
      return Profile(null);
    }
  }
}
