import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Components/Profile/user_map_model.dart';
import 'package:swd_project/Model/User/UserReview.dart';

class SlideMenu extends StatefulWidget {
  @override
  _SlideMenuState createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> {
  final LocalStorage storage = new LocalStorage('user');

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 18, 32, 50),
      ),
      child: Column(
        children: [
          Material(
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Route route =
                      MaterialPageRoute(builder: (context) => UserProfile());
                  Navigator.push(context, route);
                },
                splashColor: Color.fromARGB(255, 18, 32, 50),
                child: Image.network(
                  User.fromJsonProfile(storage.getItem('user')).avatarUrl,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Text(
                User.fromJsonProfile(storage.getItem('user')).name,
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
