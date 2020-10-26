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
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3)),
        ),
        child: InkWell(
          splashColor: Color.fromARGB(255, 18, 32, 50),
          onTap: (){},
          child: Column(
            children: <Widget>[
              SizedBox(height: 0.0),
              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified_user),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "aaa",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                children: <Widget>[
                  ExpansionTile(
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(35, 0, 5, 0),
                      child: Text("ss"),
                    ),
                    children: <Widget>[
                      ListTile(
                        title:  Padding(
                          padding: EdgeInsets.fromLTRB(40, 0, 5, 0),
                          child: Text("data"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         Icon(icon),
          //         Padding(
          //           padding: const EdgeInsets.all(10),
          //           child: Text(
          //             text,
          //             style: TextStyle(
          //               fontSize: 17,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Icon(Icons.arrow_right),
          //   ],
          // ),
        ),
      ),
    );
  }
}
