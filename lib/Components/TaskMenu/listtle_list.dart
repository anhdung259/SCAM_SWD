import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/get_Categories_Bloc.dart';
import 'package:swd_project/Model/Category/Category.dart';

import 'generate_menu.dart';

class ListTitle extends StatefulWidget {
  @override
  _ListTitleState createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitle> {
  @override
  void initState() {
    super.initState();
    cateBloc.getListCate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<List<Category>>(
          stream: cateBloc.listCategory,
          builder: (context, AsyncSnapshot<List<Category>> snapshot) {
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

  Widget _buildGenresWidget(List<Category> data) {
    List<Category> nullList = data;
    if (nullList.length == 0) {
      return Container(
        child: Text("No cate"),
      );
    } else {
      return GenerateMenu(categories: nullList);
    }
  }
}
