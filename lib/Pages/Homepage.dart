import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Components/CategoryList.dart';
import 'package:swd_project/Components/SearchBar.dart';
import 'package:swd_project/Components/TaskMenu/SlideMenu.dart';
import 'package:swd_project/Components/TaskMenu/TaskMenu.dart';

import '../Components/CategoryList.dart';
import '../Model/Category.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 32, 50),
          title: Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  EvaIcons.searchOutline,
                  color: Colors.white,
                ),
                onPressed: () {
                  showSearch(context: (context), delegate: searchBar);
                })
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SlideMenu(),
            ],
          ),
        ),
        body: ListView(
          children: [CategoryList()],
        ));
  }
}
