import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Components/SearchBar.dart';

import 'package:swd_project/Components/TaskMenu/ListtleList.dart';
import 'package:swd_project/Components/TaskMenu/SlideMenu.dart';
import 'package:swd_project/Components/TaskMenu/SignOut.dart';
import 'package:swd_project/Model/User.dart';

class profileOfUser extends StatefulWidget {
  final User user;

  const profileOfUser({Key key, this.user}) : super(key: key);
  @override
  _profileOfUser createState() => _profileOfUser(user);
}

class _profileOfUser extends State<profileOfUser> {
  final _controller = ScrollController();
  final User user;
  _profileOfUser(this.user);

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
        body: Container());
  }
}
