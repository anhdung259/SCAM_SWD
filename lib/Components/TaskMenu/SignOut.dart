import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Sign_in_Bloc.dart';

import '../SignIn.dart';

class CusListTitle extends StatefulWidget {
  @override
  _CusListTitleState createState() => _CusListTitleState();
}

class _CusListTitleState extends State<CusListTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Container(
        child: InkWell(
          splashColor: Color.fromARGB(255, 18, 32, 50),
          onTap: () {
            SignOutGG();
            Route route = MaterialPageRoute(builder: (context) => SignIn());
            Navigator.push(context, route);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "Đăng xuất".toUpperCase(),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
