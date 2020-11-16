import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Components/ListProduct/search_bar.dart';
import 'package:swd_project/Components/Profile/user_map_model.dart';
import 'package:swd_project/Components/TaskMenu/listtle_list.dart';
import 'package:swd_project/Pages/home_content.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("logoApp.png"),
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(right: 200),
          child: Text(
            "GS",
            style: TextStyle(color: Colors.black),
          ),
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
      body: _showContent,
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 50,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.blueGrey[800],
          ),
          Icon(
            Icons.category,
            size: 30,
            color: Colors.blueGrey[800],
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.blueGrey[800],
          ),
        ],
        //animationCurve: Curves.easeInOut,
        onTap: (index) {
          setState(() {
            _showContent = choiceWidgetToshow(index);
          });
        },
      ),
    );
  }

  Widget _showContent = new homeContent();
  final _listCategory = new ListTitle();
  final _home = new homeContent();
  final _profile = new UserProfile();

  Widget choiceWidgetToshow(int index) {
    switch (index) {
      case 0:
        {
          return _home;
        }
      case 1:
        {
          return _listCategory;
        }
      case 2:
        {
          return _profile;
        }
      default:
        break;
    }
  }
}
