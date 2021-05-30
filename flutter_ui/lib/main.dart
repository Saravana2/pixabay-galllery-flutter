import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/helper_screens.dart';
import 'package:flutter_ui/screens/tab1/explore_screen.dart';
import 'package:flutter_ui/screens/tab2/chat_list_screen.dart';

import 'screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pix Gallery',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(),
      //home: ImageDetailScreen(null,hasPrev: false,hasNext: false,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final List<Widget> _children = [
    ExplorePage(),
    UnderDevelopmentPage(),
    ChatListScreen(),
    UnderDevelopmentPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        toolbarHeight: 30.0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0.0,
      ),
      body: _children[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: 'explore',
              icon: Icon(Icons.search, color: getColourByPosition(0))),
          BottomNavigationBarItem(
              label: 'add',
              icon:
                  Icon(Icons.add_box_outlined, color: getColourByPosition(1))),
          BottomNavigationBarItem(
              label: 'message',
              icon:
                  Icon(Icons.message_outlined, color: getColourByPosition(2))),
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(Icons.house_rounded, color: getColourByPosition(3))),
        ],
      ),
    );
  }

  _onTapped(int position) {
    if (position != _currentPage) {
      setState(() {
        _currentPage = position;
      });
    }
  }

  Color getColourByPosition(int position) {
    if (position == _currentPage) return Colors.black;
    return Colors.black26;
  }
}
