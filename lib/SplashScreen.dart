import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transaction_application/ViewScreen.dart';

class SplashScreen extends StatefulWidget
{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ViewScreen(),)
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.0,),
                  Text(" Transaction Application",style:TextStyle(
                   color: Colors.orange.shade700,
                    fontWeight: FontWeight.w700,
                    fontSize: 17.0
                  )),
                  SizedBox(height: 10.0,),
                  Text(" Welcome",style:TextStyle(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0
                  )),
                  SizedBox(height: 200.0,),
                  Image.asset("img/Tlogo.png",width: 150.0,height: 150.0,),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


