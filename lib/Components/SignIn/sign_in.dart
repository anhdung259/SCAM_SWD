import 'package:flutter/material.dart';
import 'package:swd_project/Pages/home_page.dart';

import '../../Pages/home_page.dart';
import 'package:swd_project/Bloc/sign_in_Bloc.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("logoApp.png"),
                height: 200,
              ),
              SizedBox(height: 30),
              _btnGoogleSignIn("logoGoogle.png", "Sign in with Google"),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  //google
  Widget _btnGoogleSignIn(String url, String text) {
    return Container(
      width: 300,
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          signInWithGG().then((result) {
            if (result != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return MyHomePage();
                  },
                ),
              );
            }
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image(
                  image: AssetImage(url),
                  height: 35.0,
                  width: 35.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Facebook
}
