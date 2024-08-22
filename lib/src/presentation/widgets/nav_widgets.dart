import 'package:bd_shop/src/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

Widget buildPage(int index){
  List<Widget> _widget = const [
    HomeScreen(),
   Center(child: Text("Explore"),),
   Center(child: Text("Chat"),),
   Center(child: Text("Profile"),),
  ];
 return _widget[index];
}