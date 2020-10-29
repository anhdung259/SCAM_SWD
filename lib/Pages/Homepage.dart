import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Components/CategoryData.dart';
import 'package:swd_project/Components/SearchBar.dart';

import 'file:///E:/CN7/SWD/swd_project/lib/Widget/SlideShow.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlideMenu(),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: ListTitle(),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CusListTitle(),
              ),
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
            children: [SlideShow(), CategoryListIncludeProduct()],
          ),
        ));
  }
}
