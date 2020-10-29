import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          onPressed: () {},
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
    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
    //   child: Container(
    //     child: InkWell(
    //       splashColor: Color.fromARGB(255, 18, 32, 50),
    //       onTap: () {
    //         SignOutGG();
    //         Route route =
    //             MaterialPageRoute(builder: (context) => signinScreen());
    //         Navigator.push(context, route);
    //       },
    //       child: Container(
    //         child: RaisedButton(
    //           color: Colors.red,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(20),
    //               side: BorderSide(
    //                 color: Colors.blueGrey[800],
    //                 width: 1,
    //                 style: BorderStyle.solid,
    //               )),
    //           child: Text(
    //             "Đăng xuất".toUpperCase(),
    //             style: TextStyle(
    //               color: Colors.blueGrey[800],
    //               fontSize: 17,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
