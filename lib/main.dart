import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Bloc/sign_in_Bloc.dart';
import 'package:swd_project/Components/SignIn/signin_screen.dart';
import 'Pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final LocalStorage _storage = LocalStorage('token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AvatarGlow(
              endRadius: 90,
              duration: Duration(seconds: 2),
              glowColor: Colors.red,
              repeat: true,
              repeatPauseDuration: Duration(seconds: 2),
              startDelay: Duration(seconds: 1),
              child: Material(
                elevation: 15,
                shape: CircleBorder(),
                child: Image.asset("logoApp.png"),
                // child: CircleAvatar(
                //   backgroundColor: Color.fromARGB(255, 18, 32, 50),
                //   child: Image.asset("logoApp.png",),
                //   radius: 70,
                // ),
              ),
            ),
            Text(
              "Good Software,Good Service!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.27),
            ),
            Container(
                height: 170, child: Image(image: AssetImage('loadGS.gif')))
          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 1), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    if (checkLogin()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => signinScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }
}
