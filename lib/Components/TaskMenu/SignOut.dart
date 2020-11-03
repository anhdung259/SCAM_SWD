import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Sign_in_Bloc.dart';
import 'package:swd_project/Components/SignIn/SigninScreen.dart';

class CusListTitle extends StatefulWidget {
  @override
  _CusListTitleState createState() => _CusListTitleState();
}

class _CusListTitleState extends State<CusListTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: ButtonTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: RaisedButton(
          color: Colors.redAccent,
          onPressed: () {
            SignOutGG();
            Route route =
                MaterialPageRoute(builder: (context) => signinScreen());
            Navigator.push(context, route);
          },
          child: Text(
              "Đăng xuất".toUpperCase(),
              style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
