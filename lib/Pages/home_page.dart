import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Components/Category/category_data.dart';
import 'package:swd_project/Components/ListProduct/search_bar.dart';
import 'package:swd_project/Components/Recommend/recommend_by_industry.dart';
import 'package:swd_project/Components/TaskMenu/listtle_list.dart';
import 'package:swd_project/Components/TaskMenu/slide_menu.dart';
import 'package:swd_project/Components/TaskMenu/sign_out.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';
import 'package:swd_project/Widget/slide_show.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalStorage storage = LocalStorage('user');
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: new IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  EvaIcons.searchOutline,
                  color: Colors.black,
                ),
                onPressed: () {
                  showSearch(context: (context), delegate: searchBar);
                })
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SlideMenu(),
              ListTitle(),
              SizedBox(
                height: 5,
              ),
              CusListTitle(),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.07),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: ListView(
            controller: _controller,
            children: [
              SlideShow(),
              loadRecommend(),
              CategoryListIncludeProduct()
            ],
          ),
        ));
  }

  Widget loadRecommend() {
    return FutureBuilder(
        future: storage.ready,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var user = User.fromJsonProfile(storage.getItem('user'));
            return RecommendForUser(
              userId: user.id,
            );
          } else if (snapshot.hasError) {
            return BuildError(
              error: snapshot.error,
            );
          } else {
            return BuildLoading();
          }
        });
  }
}
