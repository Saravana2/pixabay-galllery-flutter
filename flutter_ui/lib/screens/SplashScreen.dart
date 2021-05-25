import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    startTime(context);
    return Container(
      color: const Color(0xff18740A),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("image/full_icon.png",height: 230,width: 230,),
          SizedBox(width: 0,height: 50,),
          Text("Pix Gallery",textAlign: TextAlign.center,style: TextStyle(decoration:TextDecoration.none,fontSize: 40.0,fontWeight: FontWeight.w900,color: Colors.white),)
        ],
        ),
      ),
    );
  }

  startTime(BuildContext context)async{
    Timer(Duration(seconds: 3),(){navigationPage(context);});
  }

  navigationPage(BuildContext context){
    Navigator.pushReplacement(context,MaterialPageRoute(
        builder: (context) => MyHomePage()));
  }
}