import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/pages/intro_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
        return IntroPage();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "News App",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
