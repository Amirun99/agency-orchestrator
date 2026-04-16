import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_jsonplaceholder/screens/comments/comments_view.dart';
import 'package:flutter_jsonplaceholder/screens/photo/photo_view.dart';

import '../posts/posts_view.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  List<Color> colorList = const [
    Color(0xff171B70),
    Color(0xff410D75),
    Color(0xff032340),
    Color(0xff050340),
    Color(0xff2c0340),
  ];

  List<Alignment> alignmentList = [
    Alignment.topCenter,
    Alignment.bottomCenter,
  ];
  Color bottomColor = Color(0xff092646);
  Color topColor = Color(0xff410d75);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;
  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(microseconds: 0), () {
      setState(() {
        bottomColor = Color(0xff33267c);
      });
    });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Mock API')),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Comments'),
                Tab(text: 'Photo'),
              ],
            ),
          ),
          body: AnimatedContainer(
            duration: const Duration(seconds: 2),
            onEnd: () {
              setState(() {
                colorIndex = colorIndex + 1;
                bottomColor = colorList[colorIndex % colorList.length];
                topColor = colorList[(colorIndex + 1) % colorList.length];
              });
            },
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: begin,
                end: end,
                colors: [bottomColor, topColor],
              ),
            ),
            child: TabBarView(
              children: [
                PostsPage(),
                CommentsPage(),
                PhotoPage(),
              ],
            ),
          ),
        ),
      );
}
