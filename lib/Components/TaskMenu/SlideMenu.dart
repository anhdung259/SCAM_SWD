import 'package:flutter/material.dart';

class SlideMenu extends StatefulWidget {
  @override
  _SlideMenuState createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 18, 32, 50),
      ),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                "logoApp.png",
                width: 80,
                height: 80,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Name of user",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
