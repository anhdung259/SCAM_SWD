import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Components/ListProduct/search_bar.dart';
import 'package:swd_project/Components/Profile/user_map_model.dart';
import 'package:swd_project/Components/TaskMenu/listtle_list.dart';
import 'package:swd_project/Components/TaskMenu/slide_menu.dart';
import 'package:swd_project/Components/TaskMenu/sign_out.dart';
import 'package:swd_project/Pages/home_content.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset("logoApp.png"),
        title: Text(
          "GS",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        actions: [
          IconButton(
              icon: Icon(
                EvaIcons.searchOutline,
                color: Colors.blueGrey[800],
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

  //Controller bottom bar

  Widget _showContent = new homeContent();
  final _listCategory = new ListTitle();
  final _home = new homeContent();
  final _profile = new UserProfile();

  Widget choiceWidgetToshow(int index){
    switch(index){
      case 0:{
        return _home;
        break;
      }
      case 1:{
        return _listCategory;
        break;
      }
      case 2:{
        return _profile;
        break;
      }
      default:break;
    }
  }
}
