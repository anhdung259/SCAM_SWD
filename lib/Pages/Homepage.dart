import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Components/CategoryListIncludeProduct.dart';
import 'package:swd_project/Components/SearchBar.dart';

import 'package:swd_project/Components/SlideShow.dart';
import 'package:swd_project/Components/TaskMenu/ListtleList.dart';
import 'package:swd_project/Components/TaskMenu/SlideMenu.dart';
import 'package:swd_project/Components/TaskMenu/SignOut.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            borderRadius: BorderRadius.circular(50),
          ),
          child: ListView(
            controller: _controller,
            children: [SlideShow(), CategoryListIncludeProduct()],
          ),
        ));
  }
}
